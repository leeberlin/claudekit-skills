//
//  ThumbnailsView.swift
//  PDFEditor
//
//  Sidebar with page thumbnails
//

import SwiftUI
import PDFKit

struct ThumbnailsView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedPageIndex: Int = 0

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Pages")
                    .font(.headline)
                    .foregroundColor(.secondary)

                Spacer()

                if let document = appState.currentDocument {
                    Text("\(document.pageCount)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)

            Divider()

            // Thumbnails List
            if let document = appState.currentDocument {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(0..<document.pageCount, id: \.self) { index in
                            ThumbnailPageView(
                                page: document.page(at: index),
                                pageNumber: index + 1,
                                isSelected: appState.currentPage == index
                            )
                            .onTapGesture {
                                appState.currentPage = index
                            }
                            .contextMenu {
                                PageContextMenu(pageIndex: index)
                            }
                        }
                    }
                    .padding()
                }
            } else {
                Spacer()
                Text("No pages")
                    .foregroundColor(.secondary)
                Spacer()
            }
        }
    }
}

// MARK: - Thumbnail Page View
struct ThumbnailPageView: View {
    let page: PDFPage?
    let pageNumber: Int
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 8) {
            if let page = page {
                PageThumbnailImage(page: page)
                    .frame(height: 150)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isSelected ? Color.accentColor : Color.gray.opacity(0.3), lineWidth: isSelected ? 3 : 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
            }

            Text("Page \(pageNumber)")
                .font(.caption)
                .foregroundColor(isSelected ? .accentColor : .secondary)
        }
    }
}

// MARK: - Page Thumbnail Image
struct PageThumbnailImage: NSViewRepresentable {
    let page: PDFPage

    func makeNSView(context: Context) -> NSImageView {
        let imageView = NSImageView()
        imageView.imageScaling = .scaleProportionallyUpOrDown
        return imageView
    }

    func updateNSView(_ imageView: NSImageView, context: Context) {
        let thumbnailSize = CGSize(width: 200, height: 300)
        imageView.image = page.thumbnail(of: thumbnailSize, for: .mediaBox)
    }
}

// MARK: - Page Context Menu
struct PageContextMenu: View {
    @EnvironmentObject var appState: AppState
    let pageIndex: Int

    var body: some View {
        Button("Rotate Left") {
            rotatePage(angle: -90)
        }

        Button("Rotate Right") {
            rotatePage(angle: 90)
        }

        Divider()

        Button("Duplicate Page") {
            duplicatePage()
        }

        Divider()

        Button("Delete Page", role: .destructive) {
            deletePage()
        }
        .disabled(appState.currentDocument?.pageCount ?? 0 <= 1)
    }

    private func rotatePage(angle: Int) {
        guard let page = appState.currentDocument?.page(at: pageIndex) else { return }
        page.rotation = (page.rotation + angle) % 360
    }

    private func duplicatePage() {
        guard let document = appState.currentDocument,
              let page = document.page(at: pageIndex),
              let pageData = page.dataRepresentation,
              let newPage = PDFPage(image: NSImage(data: pageData) ?? NSImage()) else { return }

        document.insert(newPage, at: pageIndex + 1)
    }

    private func deletePage() {
        guard let document = appState.currentDocument,
              document.pageCount > 1 else { return }

        document.removePage(at: pageIndex)

        if appState.currentPage >= pageIndex && appState.currentPage > 0 {
            appState.currentPage -= 1
        }
    }
}
