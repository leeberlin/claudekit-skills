//
//  FormFillingView.swift
//  PDFEditor
//
//  Form field detection and filling
//

import SwiftUI
import PDFKit

struct FormFillingView: View {
    @EnvironmentObject var appState: AppState
    @State private var formFields: [FormField] = []
    @State private var selectedField: FormField?

    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Form Fields")
                    .font(.headline)
                    .foregroundColor(.secondary)

                Spacer()

                Button(action: detectFormFields) {
                    Image(systemName: "arrow.clockwise")
                }
                .help("Detect Form Fields")
            }
            .padding()

            Divider()

            // Form Fields List
            if formFields.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.secondary)

                    Text("No form fields detected")
                        .foregroundColor(.secondary)

                    Button("Detect Fields") {
                        detectFormFields()
                    }
                    .buttonStyle(.borderedProminent)
                }
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(formFields) { field in
                            FormFieldRow(
                                field: field,
                                isSelected: selectedField?.id == field.id
                            )
                            .onTapGesture {
                                selectedField = field
                                navigateToField(field)
                            }
                        }
                    }
                    .padding()
                }

                Divider()

                // Fill All Button
                Button(action: fillAllFields) {
                    Label("Auto-Fill All Fields", systemImage: "wand.and.stars")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .frame(width: 300)
        .onAppear {
            detectFormFields()
        }
    }

    private func detectFormFields() {
        formFields = []

        guard let document = appState.currentDocument else { return }

        for pageIndex in 0..<document.pageCount {
            guard let page = document.page(at: pageIndex) else { continue }

            // Detect form field annotations
            for annotation in page.annotations {
                if annotation.isKind(of: PDFAnnotation.self) {
                    let fieldType = getFieldType(annotation)
                    if fieldType != .unknown {
                        let field = FormField(
                            id: UUID(),
                            annotation: annotation,
                            type: fieldType,
                            pageIndex: pageIndex,
                            fieldName: annotation.fieldName ?? "Unnamed Field",
                            value: annotation.widgetStringValue ?? ""
                        )
                        formFields.append(field)
                    }
                }
            }
        }
    }

    private func getFieldType(_ annotation: PDFAnnotation) -> FormFieldType {
        if annotation.widgetFieldType == .text {
            return .textField
        } else if annotation.widgetFieldType == .button {
            if annotation.buttonWidgetState == .onState {
                return .checkbox
            } else {
                return .radioButton
            }
        } else if annotation.widgetFieldType == .choice {
            return .dropdown
        }
        return .unknown
    }

    private func navigateToField(_ field: FormField) {
        appState.currentPage = field.pageIndex
        // In a real implementation, you'd also scroll to and highlight the field
    }

    private func fillAllFields() {
        // Auto-fill logic - this is a placeholder
        // In a real app, you'd have AI or template-based filling
        for field in formFields {
            switch field.type {
            case .textField:
                field.annotation.widgetStringValue = "Sample Text"
            case .checkbox:
                field.annotation.buttonWidgetState = .onState
            case .radioButton:
                field.annotation.buttonWidgetState = .onState
            default:
                break
            }
        }
    }
}

// MARK: - Form Field Model
struct FormField: Identifiable {
    let id: UUID
    let annotation: PDFAnnotation
    let type: FormFieldType
    let pageIndex: Int
    let fieldName: String
    var value: String
}

enum FormFieldType {
    case textField
    case checkbox
    case radioButton
    case dropdown
    case signature
    case unknown

    var icon: String {
        switch self {
        case .textField: return "textformat.abc"
        case .checkbox: return "checkmark.square"
        case .radioButton: return "circle.circle"
        case .dropdown: return "list.bullet"
        case .signature: return "signature"
        case .unknown: return "questionmark.square"
        }
    }
}

// MARK: - Form Field Row
struct FormFieldRow: View {
    let field: FormField
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: field.type.icon)
                    .foregroundColor(.accentColor)

                Text(field.fieldName)
                    .font(.body)
                    .lineLimit(1)

                Spacer()

                Text("Page \(field.pageIndex + 1)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            if !field.value.isEmpty {
                Text(field.value)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(4)
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(4)
            }
        }
        .padding()
        .background(isSelected ? Color.accentColor.opacity(0.2) : Color(NSColor.controlBackgroundColor))
        .cornerRadius(8)
    }
}
