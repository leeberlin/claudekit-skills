//
//  PDFEditorCommands.swift
//  PDFEditor
//
//  Menu commands and keyboard shortcuts
//

import SwiftUI

struct PDFEditorCommands: Commands {
    var body: some Commands {
        // File Commands
        CommandGroup(replacing: .newItem) {
            Button("Open...") {
                NotificationCenter.default.post(name: .openFile, object: nil)
            }
            .keyboardShortcut("o", modifiers: .command)

            Button("Save") {
                NotificationCenter.default.post(name: .saveFile, object: nil)
            }
            .keyboardShortcut("s", modifiers: .command)

            Button("Save As...") {
                NotificationCenter.default.post(name: .saveFileAs, object: nil)
            }
            .keyboardShortcut("s", modifiers: [.command, .shift])

            Divider()

            Button("Export...") {
                NotificationCenter.default.post(name: .exportFile, object: nil)
            }
            .keyboardShortcut("e", modifiers: .command)
        }

        // Edit Commands
        CommandGroup(replacing: .undoRedo) {
            Button("Undo") {
                NotificationCenter.default.post(name: .undo, object: nil)
            }
            .keyboardShortcut("z", modifiers: .command)

            Button("Redo") {
                NotificationCenter.default.post(name: .redo, object: nil)
            }
            .keyboardShortcut("z", modifiers: [.command, .shift])

            Divider()

            Button("Select All") {
                NotificationCenter.default.post(name: .selectAll, object: nil)
            }
            .keyboardShortcut("a", modifiers: .command)

            Button("Delete") {
                NotificationCenter.default.post(name: .delete, object: nil)
            }
            .keyboardShortcut(.delete, modifiers: [])
        }

        // View Commands
        CommandMenu("View") {
            Button("Zoom In") {
                NotificationCenter.default.post(name: .zoomIn, object: nil)
            }
            .keyboardShortcut("+", modifiers: .command)

            Button("Zoom Out") {
                NotificationCenter.default.post(name: .zoomOut, object: nil)
            }
            .keyboardShortcut("-", modifiers: .command)

            Button("Actual Size") {
                NotificationCenter.default.post(name: .actualSize, object: nil)
            }
            .keyboardShortcut("0", modifiers: .command)

            Divider()

            Button("Toggle Thumbnails") {
                NotificationCenter.default.post(name: .toggleThumbnails, object: nil)
            }
            .keyboardShortcut("t", modifiers: [.command, .option])

            Button("Toggle Properties") {
                NotificationCenter.default.post(name: .toggleProperties, object: nil)
            }
            .keyboardShortcut("p", modifiers: [.command, .option])
        }

        // Tools Commands
        CommandMenu("Tools") {
            Button("Select Tool") {
                NotificationCenter.default.post(name: .selectTool, object: Tool.select)
            }
            .keyboardShortcut("v", modifiers: .command)

            Button("Text Tool") {
                NotificationCenter.default.post(name: .selectTool, object: Tool.text)
            }
            .keyboardShortcut("t", modifiers: .command)

            Button("Draw Tool") {
                NotificationCenter.default.post(name: .selectTool, object: Tool.draw)
            }
            .keyboardShortcut("d", modifiers: .command)

            Button("Highlight Tool") {
                NotificationCenter.default.post(name: .selectTool, object: Tool.highlight)
            }
            .keyboardShortcut("h", modifiers: .command)

            Divider()

            Button("Rectangle Tool") {
                NotificationCenter.default.post(name: .selectTool, object: Tool.rectangle)
            }
            .keyboardShortcut("r", modifiers: .command)

            Button("Circle Tool") {
                NotificationCenter.default.post(name: .selectTool, object: Tool.circle)
            }
            .keyboardShortcut("c", modifiers: .command)

            Button("Line Tool") {
                NotificationCenter.default.post(name: .selectTool, object: Tool.line)
            }
            .keyboardShortcut("l", modifiers: .command)
        }

        // Page Commands
        CommandMenu("Page") {
            Button("Next Page") {
                NotificationCenter.default.post(name: .nextPage, object: nil)
            }
            .keyboardShortcut(.downArrow, modifiers: [])

            Button("Previous Page") {
                NotificationCenter.default.post(name: .previousPage, object: nil)
            }
            .keyboardShortcut(.upArrow, modifiers: [])

            Divider()

            Button("Rotate Left") {
                NotificationCenter.default.post(name: .rotateLeft, object: nil)
            }
            .keyboardShortcut("l", modifiers: [.command, .option])

            Button("Rotate Right") {
                NotificationCenter.default.post(name: .rotateRight, object: nil)
            }
            .keyboardShortcut("r", modifiers: [.command, .option])

            Divider()

            Button("Add Page") {
                NotificationCenter.default.post(name: .addPage, object: nil)
            }

            Button("Delete Page") {
                NotificationCenter.default.post(name: .deletePage, object: nil)
            }
        }
    }
}

// MARK: - Notification Names
extension Notification.Name {
    static let openFile = Notification.Name("openFile")
    static let saveFile = Notification.Name("saveFile")
    static let saveFileAs = Notification.Name("saveFileAs")
    static let exportFile = Notification.Name("exportFile")
    static let undo = Notification.Name("undo")
    static let redo = Notification.Name("redo")
    static let selectAll = Notification.Name("selectAll")
    static let delete = Notification.Name("delete")
    static let zoomIn = Notification.Name("zoomIn")
    static let zoomOut = Notification.Name("zoomOut")
    static let actualSize = Notification.Name("actualSize")
    static let toggleThumbnails = Notification.Name("toggleThumbnails")
    static let toggleProperties = Notification.Name("toggleProperties")
    static let selectTool = Notification.Name("selectTool")
    static let nextPage = Notification.Name("nextPage")
    static let previousPage = Notification.Name("previousPage")
    static let rotateLeft = Notification.Name("rotateLeft")
    static let rotateRight = Notification.Name("rotateRight")
    static let addPage = Notification.Name("addPage")
    static let deletePage = Notification.Name("deletePage")
}
