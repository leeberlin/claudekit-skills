//
//  ContentView.swift
//  PDFEditor
//
//  Main view with sidebar, toolbar, and PDF viewer
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedFile: URL?

    var body: some View {
        NavigationSplitView {
            // Sidebar - Thumbnails
            if appState.showThumbnails {
                ThumbnailsView()
                    .frame(minWidth: 150, maxWidth: 250)
                    .background(Color(NSColor.controlBackgroundColor))
            }
        } detail: {
            // Main Content
            VStack(spacing: 0) {
                // Toolbar
                ToolbarView()
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color(NSColor.windowBackgroundColor))

                Divider()

                // PDF Viewer
                if appState.currentDocument != nil {
                    PDFViewerView()
                } else {
                    EmptyStateView(onOpenFile: openFile)
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigation) {
                Button(action: { appState.showThumbnails.toggle() }) {
                    Image(systemName: "sidebar.left")
                }
                .help("Toggle Thumbnails")
            }

            ToolbarItemGroup(placement: .primaryAction) {
                Button(action: openFile) {
                    Label("Open", systemImage: "doc.badge.plus")
                }
                .help("Open PDF")

                if appState.currentDocument != nil {
                    Button(action: saveFile) {
                        Label("Save", systemImage: "square.and.arrow.down")
                    }
                    .help("Save PDF")
                }
            }
        }
        .navigationTitle(selectedFile?.lastPathComponent ?? "PDF Editor")
    }

    private func openFile() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.allowedContentTypes = [.pdf]

        if panel.runModal() == .OK, let url = panel.url {
            selectedFile = url
            loadPDF(from: url)
        }
    }

    private func loadPDF(from url: URL) {
        if let document = PDFDocument(url: url) {
            appState.currentDocument = document
            appState.currentPage = 0
        }
    }

    private func saveFile() {
        let panel = NSSavePanel()
        panel.allowedContentTypes = [.pdf]
        panel.nameFieldStringValue = selectedFile?.lastPathComponent ?? "document.pdf"

        if panel.runModal() == .OK, let url = panel.url {
            appState.currentDocument?.write(to: url)
        }
    }
}

// MARK: - Empty State
struct EmptyStateView: View {
    let onOpenFile: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 80))
                .foregroundColor(.secondary)

            Text("No PDF Open")
                .font(.title)
                .fontWeight(.semibold)

            Text("Open a PDF file to start editing")
                .foregroundColor(.secondary)

            Button(action: onOpenFile) {
                Label("Open PDF File", systemImage: "doc.badge.plus")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(NSColor.controlBackgroundColor))
    }
}
