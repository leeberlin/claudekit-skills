# PDF Editor for macOS

<div align="center">

![macOS](https://img.shields.io/badge/macOS-13.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0+-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

**Một ứng dụng chỉnh sửa PDF chuyên nghiệp cho macOS**

Được xây dựng với Swift, SwiftUI và PDFKit

[Tính năng](#-tính-năng) • [Cài đặt](#-cài-đặt) • [Sử dụng](#-sử-dụng) • [Keyboard Shortcuts](#-keyboard-shortcuts) • [Development](#-development)

</div>

---

## 🚀 Quick Start - Chạy ngay trong 3 bước!

```bash
# 1. Mở project
cd macos-pdf-editor
./run.sh

# 2. Trong Xcode: Chọn "My Mac" ở góc trên trái

# 3. Nhấn ⌘ + R
```

**Done!** App sẽ launch sau 2-5 phút build.

📖 **Chi tiết?** → Xem [RUN_LOCAL.md](RUN_LOCAL.md) hoặc [CHECKLIST.md](CHECKLIST.md)

---

## 📸 Screenshots

> *Screenshots sẽ được thêm vào khi build ứng dụng*

## ✨ Tính năng

### 🖊️ Công cụ chỉnh sửa văn bản
- ✍️ Thêm text annotations vào bất kỳ vị trí nào
- 📝 Điền form fields (text fields, checkboxes, radio buttons)
- 🎨 Tùy chỉnh font, size và màu sắc
- 📋 Tự động phát hiện và điền form fields

### 🎨 Công cụ vẽ và đánh dấu
- ✏️ Vẽ tự do (freehand drawing)
- 🟦 Vẽ hình: Rectangle, Circle, Line, Arrow
- 🖍️ Highlight text với nhiều màu sắc
- ⚡ Underline và strikethrough
- 🎯 Tùy chỉnh độ dày và màu sắc stroke

### 📄 Quản lý trang
- ➕ Thêm và xóa trang
- 🔄 Xoay trang (90°, 180°, 270°)
- 📑 Sao chép trang
- 🖼️ Thumbnails sidebar với preview
- 🔀 Sắp xếp lại thứ tự trang (drag & drop)

### 🔍 Tìm kiếm nâng cao
- 🔎 Tìm kiếm văn bản trong toàn bộ document
- 📍 Navigate qua các kết quả tìm kiếm
- 💡 Highlight kết quả tìm thấy
- ⚡ Tìm kiếm real-time

### 💾 File Operations
- 📂 Mở file PDF
- 💾 Save và Save As
- 📤 Export PDF
- ↩️ Undo/Redo với history đầy đủ
- 🔄 Auto-save (optional)

### 🎯 UI/UX Chuyên nghiệp
- 🌓 Hỗ trợ Dark Mode
- ⚡ Performance tối ưu
- 🎨 Giao diện hiện đại với SwiftUI
- 🖱️ Zoom in/out mượt mà
- ⌨️ Keyboard shortcuts đầy đủ
- 📱 Native macOS experience

## 🚀 Cài đặt

### Yêu cầu hệ thống
- macOS 13.0 (Ventura) trở lên
- Xcode 15.0 trở lên
- Swift 5.9+

### Build từ source

1. **Clone repository:**
```bash
git clone https://github.com/yourusername/macos-pdf-editor.git
cd macos-pdf-editor
```

2. **Mở project trong Xcode:**
```bash
open PDFEditor.xcodeproj
```

3. **Build và Run:**
   - Chọn target device: **My Mac**
   - Nhấn `⌘ + R` để build và run
   - Hoặc: Product → Run

4. **Build for Distribution:**
```bash
xcodebuild -scheme PDFEditor -configuration Release -archivePath PDFEditor.xcarchive archive
```

## 📖 Sử dụng

### Mở file PDF
1. Launch ứng dụng
2. Click **"Open PDF File"** hoặc `⌘ + O`
3. Chọn file PDF cần chỉnh sửa

### Chỉnh sửa văn bản
1. Click vào **Text Tool** (hoặc nhấn `⌘ + T`)
2. Click vào vị trí muốn thêm text
3. Nhập nội dung
4. Tùy chỉnh font size và màu sắc từ toolbar

### Điền form fields
1. Click vào **Form Fields** trong sidebar
2. Ứng dụng sẽ tự động phát hiện các form fields
3. Click vào field để điền
4. Hoặc click **"Auto-Fill All Fields"** để điền tự động

### Vẽ và đánh dấu
1. Chọn tool từ toolbar:
   - **Draw Tool** (`⌘ + D`): Vẽ tự do
   - **Rectangle** (`⌘ + R`): Vẽ hình chữ nhật
   - **Circle** (`⌘ + C`): Vẽ hình tròn
   - **Line** (`⌘ + L`): Vẽ đường thẳng
   - **Highlight** (`⌘ + H`): Đánh dấu text
2. Drag trên PDF để vẽ
3. Tùy chỉnh màu sắc và độ dày từ toolbar

### Tìm kiếm
1. Click vào **Search icon** hoặc `⌘ + F`
2. Nhập từ khóa cần tìm
3. Navigate qua kết quả bằng ↑ ↓
4. Click vào kết quả để jump đến vị trí

### Save file
- **Save**: `⌘ + S`
- **Save As**: `⌘ + Shift + S`
- **Export**: `⌘ + E`

## ⌨️ Keyboard Shortcuts

### File Operations
- `⌘ + O` - Open PDF
- `⌘ + S` - Save
- `⌘ + Shift + S` - Save As
- `⌘ + E` - Export
- `⌘ + W` - Close Window
- `⌘ + Q` - Quit Application

### Edit
- `⌘ + Z` - Undo
- `⌘ + Shift + Z` - Redo
- `⌘ + A` - Select All
- `⌘ + Delete` - Delete Selected

### View
- `⌘ + +` - Zoom In
- `⌘ + -` - Zoom Out
- `⌘ + 0` - Actual Size
- `⌘ + Option + T` - Toggle Thumbnails
- `⌘ + Option + P` - Toggle Properties

### Tools
- `⌘ + V` - Select Tool
- `⌘ + T` - Text Tool
- `⌘ + D` - Draw Tool
- `⌘ + H` - Highlight Tool
- `⌘ + R` - Rectangle Tool
- `⌘ + C` - Circle Tool
- `⌘ + L` - Line Tool

### Page Navigation
- `↑` - Previous Page
- `↓` - Next Page
- `⌘ + Option + L` - Rotate Left
- `⌘ + Option + R` - Rotate Right

### Search
- `⌘ + F` - Find
- `⌘ + G` - Find Next
- `⌘ + Shift + G` - Find Previous

## 🛠️ Development

### Project Structure
```
macos-pdf-editor/
├── PDFEditor/
│   ├── PDFEditorApp.swift          # Main app entry point
│   ├── Info.plist                   # App configuration
│   ├── PDFEditor.entitlements      # App sandbox entitlements
│   ├── Views/
│   │   ├── ContentView.swift       # Main container view
│   │   ├── ToolbarView.swift       # Top toolbar with tools
│   │   ├── PDFViewerView.swift     # PDF viewer & editing
│   │   ├── ThumbnailsView.swift    # Sidebar thumbnails
│   │   ├── SettingsView.swift      # Settings window
│   │   ├── SearchView.swift        # Search panel
│   │   └── FormFillingView.swift   # Form fields panel
│   └── Commands/
│       └── PDFEditorCommands.swift # Menu commands
├── PDFEditor.xcodeproj/
│   └── project.pbxproj             # Xcode project file
└── README.md
```

### Architecture

Ứng dụng sử dụng **MVVM architecture** với SwiftUI:

- **Model**: PDFDocument, PDFAnnotation (từ PDFKit)
- **View**: SwiftUI views
- **ViewModel**: AppState (observable object)

#### Core Components

1. **AppState**: Quản lý global state
   - Current document
   - Selected tool
   - UI preferences
   - Undo/Redo manager

2. **PDFViewerView**: Component chính để view và edit PDF
   - Sử dụng NSViewRepresentable để wrap PDFView
   - Handle gestures (click, drag)
   - Manage annotations

3. **Toolbar**: Tools selection và properties
   - Tool buttons
   - Zoom controls
   - Color & style pickers

4. **Sidebar**: Navigation và management
   - Thumbnails view
   - Form fields list
   - Search panel

### Technologies Used

- **SwiftUI**: Modern UI framework
- **PDFKit**: Core PDF manipulation
- **Combine**: Reactive programming
- **AppKit**: macOS-specific features

### Key Classes & Extensions

```swift
// Main App State
class AppState: ObservableObject {
    @Published var currentDocument: PDFDocument?
    @Published var selectedTool: Tool
    @Published var zoomLevel: CGFloat
    // ...
}

// Tools
enum Tool {
    case select, text, draw, highlight
    case rectangle, circle, line, arrow
    case eraser
}

// PDF Viewer Coordinator
class Coordinator: NSObject {
    func handleClick(_ gesture: NSClickGestureRecognizer)
    func handleDrag(_ gesture: NSPanGestureRecognizer)
    // ...
}
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Setup
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Roadmap

### Version 1.1 (Planned)
- [ ] OCR support (text recognition)
- [ ] Digital signature
- [ ] Add images to PDF
- [ ] Merge multiple PDFs
- [ ] Split PDF into multiple files
- [ ] Batch processing

### Version 1.2 (Future)
- [ ] Cloud storage integration (iCloud, Dropbox)
- [ ] Collaboration features
- [ ] PDF comparison tool
- [ ] Templates library
- [ ] AI-powered form filling

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- Powered by [PDFKit](https://developer.apple.com/documentation/pdfkit)
- Icons from [SF Symbols](https://developer.apple.com/sf-symbols/)

## 📧 Contact

Nếu có câu hỏi hoặc góp ý, vui lòng tạo issue trên GitHub repository.

---

<div align="center">
Made with ❤️ for macOS
</div>
