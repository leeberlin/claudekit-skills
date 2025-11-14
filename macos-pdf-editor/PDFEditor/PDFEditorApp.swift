//
//  PDFEditorApp.swift
//  PDFEditor
//
//  A professional PDF editing application for macOS
//  Built with SwiftUI and PDFKit
//

import SwiftUI

@main
struct PDFEditorApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .frame(minWidth: 1000, minHeight: 700)
        }
        .commands {
            PDFEditorCommands()
        }
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)

        // Settings window
        Settings {
            SettingsView()
        }
    }
}

// MARK: - App State
class AppState: ObservableObject {
    @Published var currentDocument: PDFDocument?
    @Published var selectedTool: Tool = .select
    @Published var showThumbnails: Bool = true
    @Published var showProperties: Bool = false
    @Published var zoomLevel: CGFloat = 1.0
    @Published var currentPage: Int = 0

    // Annotation properties
    @Published var textColor: Color = .black
    @Published var fillColor: Color = .yellow
    @Published var strokeColor: Color = .red
    @Published var lineWidth: CGFloat = 2.0
    @Published var fontSize: CGFloat = 12.0
    @Published var fontName: String = "Helvetica"

    // Undo/Redo
    @Published var undoManager: UndoManager = UndoManager()
}

// MARK: - Tool Types
enum Tool: String, CaseIterable {
    case select = "Select"
    case text = "Text"
    case highlight = "Highlight"
    case draw = "Draw"
    case rectangle = "Rectangle"
    case circle = "Circle"
    case line = "Line"
    case arrow = "Arrow"
    case eraser = "Eraser"

    var icon: String {
        switch self {
        case .select: return "cursorarrow.click"
        case .text: return "textformat"
        case .highlight: return "highlighter"
        case .draw: return "pencil"
        case .rectangle: return "rectangle"
        case .circle: return "circle"
        case .line: return "line.diagonal"
        case .arrow: return "arrow.up.right"
        case .eraser: return "eraser"
        }
    }
}
