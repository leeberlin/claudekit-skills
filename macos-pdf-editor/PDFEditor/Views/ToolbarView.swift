//
//  ToolbarView.swift
//  PDFEditor
//
//  Toolbar with editing tools and controls
//

import SwiftUI

struct ToolbarView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        HStack(spacing: 16) {
            // Tool Selection
            HStack(spacing: 4) {
                ForEach(Tool.allCases, id: \.self) { tool in
                    ToolButton(
                        tool: tool,
                        isSelected: appState.selectedTool == tool
                    ) {
                        appState.selectedTool = tool
                    }
                }
            }
            .padding(4)
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(8)

            Divider()
                .frame(height: 24)

            // Zoom Controls
            HStack(spacing: 8) {
                Button(action: { zoomOut() }) {
                    Image(systemName: "minus.magnifyingglass")
                }
                .help("Zoom Out")

                Text("\(Int(appState.zoomLevel * 100))%")
                    .frame(width: 50)
                    .font(.system(.body, design: .monospaced))

                Button(action: { zoomIn() }) {
                    Image(systemName: "plus.magnifyingglass")
                }
                .help("Zoom In")

                Button(action: { fitToWidth() }) {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                }
                .help("Fit to Width")
            }

            Divider()
                .frame(height: 24)

            // Color & Style Controls
            if appState.selectedTool != .select && appState.selectedTool != .eraser {
                ColorPicker("", selection: $appState.strokeColor)
                    .labelsHidden()
                    .frame(width: 40)
                    .help("Stroke Color")

                if appState.selectedTool == .text {
                    Picker("Font Size", selection: $appState.fontSize) {
                        ForEach([8, 10, 12, 14, 16, 18, 24, 32, 48], id: \.self) { size in
                            Text("\(Int(size))").tag(CGFloat(size))
                        }
                    }
                    .frame(width: 80)
                    .help("Font Size")
                }

                if appState.selectedTool == .draw || appState.selectedTool == .line ||
                   appState.selectedTool == .arrow || appState.selectedTool == .rectangle ||
                   appState.selectedTool == .circle {
                    Slider(value: $appState.lineWidth, in: 1...10, step: 0.5)
                        .frame(width: 100)
                        .help("Line Width")
                }
            }

            Spacer()

            // Undo/Redo
            HStack(spacing: 4) {
                Button(action: { appState.undoManager.undo() }) {
                    Image(systemName: "arrow.uturn.backward")
                }
                .disabled(!appState.undoManager.canUndo)
                .help("Undo")

                Button(action: { appState.undoManager.redo() }) {
                    Image(systemName: "arrow.uturn.forward")
                }
                .disabled(!appState.undoManager.canRedo)
                .help("Redo")
            }

            // Properties Panel Toggle
            Button(action: { appState.showProperties.toggle() }) {
                Image(systemName: "sidebar.right")
            }
            .help("Toggle Properties")
        }
    }

    private func zoomIn() {
        appState.zoomLevel = min(appState.zoomLevel + 0.25, 5.0)
    }

    private func zoomOut() {
        appState.zoomLevel = max(appState.zoomLevel - 0.25, 0.25)
    }

    private func fitToWidth() {
        appState.zoomLevel = 1.0
    }
}

// MARK: - Tool Button
struct ToolButton: View {
    let tool: Tool
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: tool.icon)
                .font(.system(size: 16))
                .frame(width: 32, height: 32)
                .background(isSelected ? Color.accentColor.opacity(0.2) : Color.clear)
                .cornerRadius(6)
        }
        .buttonStyle(.plain)
        .help(tool.rawValue)
    }
}
