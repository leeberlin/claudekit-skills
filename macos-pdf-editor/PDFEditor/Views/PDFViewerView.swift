//
//  PDFViewerView.swift
//  PDFEditor
//
//  Main PDF viewer with editing capabilities
//

import SwiftUI
import PDFKit

struct PDFViewerView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        GeometryReader { geometry in
            PDFKitView(
                document: appState.currentDocument,
                currentPage: $appState.currentPage,
                zoomLevel: $appState.zoomLevel,
                selectedTool: appState.selectedTool,
                strokeColor: appState.strokeColor,
                lineWidth: appState.lineWidth,
                fontSize: appState.fontSize,
                fontName: appState.fontName,
                undoManager: appState.undoManager
            )
        }
    }
}

// MARK: - PDFKit View (UIViewRepresentable)
struct PDFKitView: NSViewRepresentable {
    let document: PDFDocument?
    @Binding var currentPage: Int
    @Binding var zoomLevel: CGFloat
    let selectedTool: Tool
    let strokeColor: Color
    let lineWidth: CGFloat
    let fontSize: CGFloat
    let fontName: String
    let undoManager: UndoManager

    func makeNSView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous
        pdfView.displayDirection = .vertical
        pdfView.usePageViewController(false)
        pdfView.backgroundColor = NSColor.controlBackgroundColor

        // Enable interactions
        pdfView.isInMarkupMode = false

        // Set delegate
        context.coordinator.pdfView = pdfView

        // Add gesture recognizers
        let clickGesture = NSClickGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleClick(_:))
        )
        pdfView.addGestureRecognizer(clickGesture)

        let dragGesture = NSPanGestureRecognizer(
            target: context.coordinator,
            action: #selector(Coordinator.handleDrag(_:))
        )
        pdfView.addGestureRecognizer(dragGesture)

        return pdfView
    }

    func updateNSView(_ pdfView: PDFView, context: Context) {
        if pdfView.document !== document {
            pdfView.document = document
        }

        pdfView.scaleFactor = zoomLevel

        // Update coordinator properties
        context.coordinator.selectedTool = selectedTool
        context.coordinator.strokeColor = NSColor(strokeColor)
        context.coordinator.lineWidth = lineWidth
        context.coordinator.fontSize = fontSize
        context.coordinator.fontName = fontName
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(currentPage: $currentPage, undoManager: undoManager)
    }

    // MARK: - Coordinator
    class Coordinator: NSObject {
        weak var pdfView: PDFView?
        @Binding var currentPage: Int
        let undoManager: UndoManager

        var selectedTool: Tool = .select
        var strokeColor: NSColor = .red
        var lineWidth: CGFloat = 2.0
        var fontSize: CGFloat = 12.0
        var fontName: String = "Helvetica"

        var isDrawing = false
        var currentPath: NSBezierPath?
        var currentAnnotation: PDFAnnotation?
        var drawingStartPoint: CGPoint?

        init(currentPage: Binding<Int>, undoManager: UndoManager) {
            self._currentPage = currentPage
            self.undoManager = undoManager
        }

        @objc func handleClick(_ gesture: NSClickGestureRecognizer) {
            guard let pdfView = pdfView,
                  let page = pdfView.currentPage else { return }

            let locationInView = gesture.location(in: pdfView)
            let locationInPage = pdfView.convert(locationInView, to: page)

            switch selectedTool {
            case .text:
                addTextAnnotation(at: locationInPage, page: page)
            case .select:
                // Handle selection
                break
            default:
                break
            }
        }

        @objc func handleDrag(_ gesture: NSPanGestureRecognizer) {
            guard let pdfView = pdfView,
                  let page = pdfView.currentPage else { return }

            let locationInView = gesture.location(in: pdfView)
            let locationInPage = pdfView.convert(locationInView, to: page)

            switch gesture.state {
            case .began:
                startDrawing(at: locationInPage, page: page)
            case .changed:
                continueDrawing(to: locationInPage, page: page)
            case .ended:
                finishDrawing(at: locationInPage, page: page)
            default:
                break
            }
        }

        private func addTextAnnotation(at point: CGPoint, page: PDFPage) {
            let bounds = CGRect(x: point.x, y: point.y, width: 200, height: 50)
            let annotation = PDFFreeTextAnnotation(bounds: bounds, withProperties: nil)

            annotation.font = NSFont(name: fontName, size: fontSize) ?? NSFont.systemFont(ofSize: fontSize)
            annotation.fontColor = strokeColor
            annotation.backgroundColor = .clear
            annotation.contents = "Text"

            page.addAnnotation(annotation)

            // Register undo
            undoManager.registerUndo(withTarget: self) { coordinator in
                page.removeAnnotation(annotation)
            }
        }

        private func startDrawing(at point: CGPoint, page: PDFPage) {
            guard selectedTool != .select && selectedTool != .text else { return }

            drawingStartPoint = point
            isDrawing = true

            if selectedTool == .draw {
                currentPath = NSBezierPath()
                currentPath?.move(to: point)
                currentPath?.lineWidth = lineWidth
            }
        }

        private func continueDrawing(to point: CGPoint, page: PDFPage) {
            guard isDrawing else { return }

            if selectedTool == .draw {
                currentPath?.line(to: point)

                // Create ink annotation for preview
                if let path = currentPath {
                    let bounds = path.bounds.insetBy(dx: -lineWidth, dy: -lineWidth)
                    let annotation = PDFAnnotation(bounds: bounds, forType: .ink, withProperties: nil)
                    annotation.color = strokeColor

                    // Remove previous preview if exists
                    if let prev = currentAnnotation {
                        page.removeAnnotation(prev)
                    }

                    currentAnnotation = annotation
                    page.addAnnotation(annotation)
                }
            }
        }

        private func finishDrawing(at point: CGPoint, page: PDFPage) {
            guard isDrawing, let startPoint = drawingStartPoint else { return }
            isDrawing = false

            // Remove preview
            if let preview = currentAnnotation {
                page.removeAnnotation(preview)
                currentAnnotation = nil
            }

            let bounds = CGRect(
                x: min(startPoint.x, point.x),
                y: min(startPoint.y, point.y),
                width: abs(point.x - startPoint.x),
                height: abs(point.y - startPoint.y)
            )

            var annotation: PDFAnnotation?

            switch selectedTool {
            case .draw:
                if let path = currentPath {
                    let inkAnnotation = PDFAnnotation(bounds: path.bounds, forType: .ink, withProperties: nil)
                    inkAnnotation.color = strokeColor

                    // Convert NSBezierPath to PDFKit ink path
                    let bezierPath = NSBezierPath()
                    bezierPath.append(path)
                    // Note: PDFKit ink annotations require specific path format
                    // This is a simplified version

                    annotation = inkAnnotation
                }
            case .rectangle:
                let rectAnnotation = PDFAnnotation(bounds: bounds, forType: .square, withProperties: nil)
                rectAnnotation.color = strokeColor
                rectAnnotation.interiorColor = .clear
                rectAnnotation.border = PDFBorder()
                rectAnnotation.border?.lineWidth = lineWidth
                annotation = rectAnnotation

            case .circle:
                let circleAnnotation = PDFAnnotation(bounds: bounds, forType: .circle, withProperties: nil)
                circleAnnotation.color = strokeColor
                circleAnnotation.interiorColor = .clear
                circleAnnotation.border = PDFBorder()
                circleAnnotation.border?.lineWidth = lineWidth
                annotation = circleAnnotation

            case .line, .arrow:
                let lineAnnotation = PDFAnnotation(bounds: bounds, forType: .line, withProperties: nil)
                lineAnnotation.color = strokeColor
                lineAnnotation.border = PDFBorder()
                lineAnnotation.border?.lineWidth = lineWidth

                // Set line points
                lineAnnotation.startPoint = startPoint
                lineAnnotation.endPoint = point

                if selectedTool == .arrow {
                    lineAnnotation.endLineStyle = .closedArrow
                }

                annotation = lineAnnotation

            case .highlight:
                // Create highlight annotation
                let highlightAnnotation = PDFAnnotation(bounds: bounds, forType: .highlight, withProperties: nil)
                highlightAnnotation.color = strokeColor.withAlphaComponent(0.3)
                annotation = highlightAnnotation

            default:
                break
            }

            if let annotation = annotation {
                page.addAnnotation(annotation)

                // Register undo
                undoManager.registerUndo(withTarget: self) { coordinator in
                    page.removeAnnotation(annotation)
                }
            }

            // Reset drawing state
            currentPath = nil
            drawingStartPoint = nil
        }
    }
}
