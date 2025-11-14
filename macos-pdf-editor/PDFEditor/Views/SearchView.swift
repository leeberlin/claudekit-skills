//
//  SearchView.swift
//  PDFEditor
//
//  Search functionality for PDF
//

import SwiftUI
import PDFKit

struct SearchView: View {
    @EnvironmentObject var appState: AppState
    @State private var searchText: String = ""
    @State private var searchResults: [PDFSelection] = []
    @State private var currentResultIndex: Int = 0
    @State private var isSearching: Bool = false

    var body: some View {
        VStack(spacing: 12) {
            // Search Header
            HStack {
                Text("Search")
                    .font(.headline)
                Spacer()
                Button(action: { isSearching = false }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal)

            // Search Input
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)

                TextField("Search in document", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        performSearch()
                    }

                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)

            // Search Results
            if !searchResults.isEmpty {
                HStack {
                    Text("\(currentResultIndex + 1) of \(searchResults.count)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Spacer()

                    Button(action: previousResult) {
                        Image(systemName: "chevron.up")
                    }
                    .disabled(currentResultIndex == 0)

                    Button(action: nextResult) {
                        Image(systemName: "chevron.down")
                    }
                    .disabled(currentResultIndex >= searchResults.count - 1)
                }
                .padding(.horizontal)

                Divider()

                // Results List
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 8) {
                        ForEach(Array(searchResults.enumerated()), id: \.offset) { index, selection in
                            SearchResultRow(
                                selection: selection,
                                index: index,
                                isSelected: index == currentResultIndex
                            )
                            .onTapGesture {
                                currentResultIndex = index
                                highlightResult(selection)
                            }
                        }
                    }
                    .padding()
                }
            } else if !searchText.isEmpty {
                Spacer()
                VStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .font(.largeTitle)
                        .foregroundColor(.secondary)
                    Text("No results found")
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
        }
        .frame(width: 300)
        .background(Color(NSColor.controlBackgroundColor))
    }

    private func performSearch() {
        guard let document = appState.currentDocument,
              !searchText.isEmpty else {
            searchResults = []
            return
        }

        searchResults = []
        document.cancelFindString()
        document.beginFindString(searchText, withOptions: .caseInsensitive)

        // Note: In a real implementation, you'd use PDFDocument's async search
        // and collect results via notification
        // This is a simplified synchronous version
        for pageIndex in 0..<document.pageCount {
            if let page = document.page(at: pageIndex) {
                let selections = page.selections(for: NSRange(location: 0, length: page.string?.count ?? 0),
                                                  matching: searchText,
                                                  options: .caseInsensitive)
                searchResults.append(contentsOf: selections)
            }
        }

        if !searchResults.isEmpty {
            currentResultIndex = 0
            highlightResult(searchResults[0])
        }
    }

    private func nextResult() {
        guard currentResultIndex < searchResults.count - 1 else { return }
        currentResultIndex += 1
        highlightResult(searchResults[currentResultIndex])
    }

    private func previousResult() {
        guard currentResultIndex > 0 else { return }
        currentResultIndex -= 1
        highlightResult(searchResults[currentResultIndex])
    }

    private func highlightResult(_ selection: PDFSelection) {
        // Navigate to the page containing this selection
        if let page = selection.pages.first,
           let document = appState.currentDocument,
           let pageIndex = document.index(for: page) {
            appState.currentPage = pageIndex
        }
    }
}

// MARK: - Search Result Row
struct SearchResultRow: View {
    let selection: PDFSelection
    let index: Int
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Result \(index + 1)")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Spacer()

                if let page = selection.pages.first {
                    Text("Page \(page.label ?? "?")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Text(selection.string ?? "")
                .font(.body)
                .lineLimit(2)
                .padding(.vertical, 4)
        }
        .padding(8)
        .background(isSelected ? Color.accentColor.opacity(0.2) : Color.clear)
        .cornerRadius(6)
    }
}

// Extension to add search capability to PDFPage
extension PDFPage {
    func selections(for range: NSRange, matching searchString: String, options: NSString.CompareOptions) -> [PDFSelection] {
        var results: [PDFSelection] = []
        guard let pageString = self.string else { return results }

        let nsString = pageString as NSString
        var searchRange = NSRange(location: 0, length: nsString.length)

        while searchRange.location < nsString.length {
            let foundRange = nsString.range(of: searchString, options: options, range: searchRange)
            if foundRange.location == NSNotFound { break }

            if let selection = self.selection(for: foundRange) {
                results.append(selection)
            }

            searchRange.location = foundRange.location + foundRange.length
            searchRange.length = nsString.length - searchRange.location
        }

        return results
    }
}
