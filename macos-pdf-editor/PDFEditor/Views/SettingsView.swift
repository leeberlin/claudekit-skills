//
//  SettingsView.swift
//  PDFEditor
//
//  Application settings
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("defaultZoomLevel") private var defaultZoomLevel: Double = 1.0
    @AppStorage("showThumbnailsOnOpen") private var showThumbnailsOnOpen: Bool = true
    @AppStorage("autoSave") private var autoSave: Bool = false
    @AppStorage("defaultTool") private var defaultTool: String = Tool.select.rawValue

    var body: some View {
        TabView {
            GeneralSettings(
                defaultZoomLevel: $defaultZoomLevel,
                showThumbnailsOnOpen: $showThumbnailsOnOpen,
                autoSave: $autoSave
            )
            .tabItem {
                Label("General", systemImage: "gearshape")
            }

            ToolsSettings(defaultTool: $defaultTool)
                .tabItem {
                    Label("Tools", systemImage: "pencil.and.scribble")
                }

            AboutSettings()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
        .frame(width: 500, height: 400)
    }
}

// MARK: - General Settings
struct GeneralSettings: View {
    @Binding var defaultZoomLevel: Double
    @Binding var showThumbnailsOnOpen: Bool
    @Binding var autoSave: Bool

    var body: some View {
        Form {
            Section("Display") {
                HStack {
                    Text("Default Zoom Level:")
                    Spacer()
                    Slider(value: $defaultZoomLevel, in: 0.25...5.0, step: 0.25)
                        .frame(width: 200)
                    Text("\(Int(defaultZoomLevel * 100))%")
                        .frame(width: 50, alignment: .trailing)
                }

                Toggle("Show thumbnails on open", isOn: $showThumbnailsOnOpen)
            }

            Section("Files") {
                Toggle("Auto-save changes", isOn: $autoSave)
                    .help("Automatically save changes to the PDF file")
            }
        }
        .padding()
    }
}

// MARK: - Tools Settings
struct ToolsSettings: View {
    @Binding var defaultTool: String

    var body: some View {
        Form {
            Section("Default Tool") {
                Picker("Tool on startup:", selection: $defaultTool) {
                    ForEach(Tool.allCases, id: \.self) { tool in
                        Text(tool.rawValue).tag(tool.rawValue)
                    }
                }
                .pickerStyle(.radioGroup)
            }
        }
        .padding()
    }
}

// MARK: - About Settings
struct AboutSettings: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.accentColor)

            Text("PDF Editor")
                .font(.title)
                .fontWeight(.bold)

            Text("Version 1.0.0")
                .foregroundColor(.secondary)

            Text("A professional PDF editing application for macOS")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            Spacer()

            Text("Built with SwiftUI and PDFKit")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
