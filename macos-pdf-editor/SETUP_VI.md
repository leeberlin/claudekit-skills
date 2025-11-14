# Hướng dẫn cài đặt và sử dụng PDF Editor

## 📋 Mục lục
1. [Yêu cầu hệ thống](#yêu-cầu-hệ-thống)
2. [Cài đặt Xcode](#cài-đặt-xcode)
3. [Build ứng dụng](#build-ứng-dụng)
4. [Hướng dẫn sử dụng chi tiết](#hướng-dẫn-sử-dụng-chi-tiết)
5. [Xử lý lỗi thường gặp](#xử-lý-lỗi-thường-gặp)

## 🖥️ Yêu cầu hệ thống

### Phần cứng tối thiểu
- Mac với chip Intel hoặc Apple Silicon (M1/M2/M3)
- RAM: 8GB (khuyến nghị 16GB)
- Dung lượng: 5GB trống

### Phần mềm
- **macOS**: Version 13.0 (Ventura) trở lên
- **Xcode**: Version 15.0 trở lên
- **Command Line Tools**: Đi kèm với Xcode

## 📦 Cài đặt Xcode

### Cách 1: Từ App Store (Khuyến nghị)
1. Mở **App Store** trên Mac
2. Tìm kiếm "Xcode"
3. Click **"Get"** hoặc **"Download"**
4. Đợi download và cài đặt (khoảng 30-40 phút)

### Cách 2: Từ Apple Developer
1. Truy cập: https://developer.apple.com/xcode/
2. Click **"Download"**
3. Đăng nhập với Apple ID
4. Tải file .xip và giải nén
5. Di chuyển Xcode vào thư mục Applications

### Cài đặt Command Line Tools
Sau khi cài Xcode, mở Terminal và chạy:
```bash
sudo xcode-select --install
```

## 🚀 Build ứng dụng

### Bước 1: Download source code

```bash
# Tạo thư mục cho project
mkdir ~/Projects
cd ~/Projects

# Clone hoặc download source code
# Nếu có git:
git clone https://github.com/yourusername/macos-pdf-editor.git

# Hoặc download ZIP từ GitHub và giải nén
```

### Bước 2: Mở project trong Xcode

```bash
cd macos-pdf-editor
open PDFEditor.xcodeproj
```

Hoặc:
1. Mở **Xcode**
2. Chọn **"Open a project or file"**
3. Navigate đến folder `macos-pdf-editor`
4. Chọn file `PDFEditor.xcodeproj`

### Bước 3: Configure project

1. **Chọn Team** (cho code signing):
   - Click vào project name ở sidebar trái
   - Chọn tab **"Signing & Capabilities"**
   - Trong **"Team"**, chọn Apple ID của bạn
   - Nếu chưa có, click **"Add Account..."**

2. **Chọn target device**:
   - Ở góc trên bên trái, chọn **"My Mac"** làm destination

### Bước 4: Build và Run

**Cách 1: Dùng keyboard shortcut**
```
⌘ + R
```

**Cách 2: Dùng menu**
1. Chọn **Product** → **Run**
2. Đợi build (lần đầu sẽ mất 2-3 phút)

**Cách 3: Dùng build button**
- Click nút ▶️ (Play) ở góc trên bên trái

### Bước 5: Build file .app để phân phối

```bash
# Build Release version
xcodebuild -scheme PDFEditor \
           -configuration Release \
           -archivePath ./PDFEditor.xcarchive \
           archive

# Export app
xcodebuild -exportArchive \
           -archivePath ./PDFEditor.xcarchive \
           -exportPath ./Release \
           -exportOptionsPlist exportOptions.plist
```

File .app sẽ được tạo trong folder `Release/`

## 📖 Hướng dẫn sử dụng chi tiết

### 1. Mở file PDF

**Cách 1: Từ ứng dụng**
1. Launch PDF Editor
2. Click button **"Open PDF File"** ở giữa màn hình
3. Chọn file PDF từ Finder
4. Click **"Open"**

**Cách 2: Dùng keyboard shortcut**
```
⌘ + O
```

**Cách 3: Drag & Drop**
- Kéo file PDF vào cửa sổ ứng dụng (tính năng này cần implement thêm)

### 2. Chỉnh sửa văn bản

#### Thêm text mới
1. Click vào icon **Text** (biểu tượng "A") trong toolbar
2. Hoặc nhấn `⌘ + T`
3. Click vào vị trí trong PDF muốn thêm text
4. Gõ nội dung
5. Tùy chỉnh:
   - **Font size**: Chọn từ dropdown (8-48pt)
   - **Màu chữ**: Click vào color picker
   - **Font family**: Chọn từ settings

#### Điền form fields
1. Click vào **Form Fields** trong sidebar phải
2. Ứng dụng sẽ tự động scan và liệt kê các fields
3. Click vào field trong danh sách để jump đến vị trí
4. Điền thông tin trực tiếp vào field
5. Hoặc click **"Auto-Fill All Fields"** để điền tự động

### 3. Vẽ và đánh dấu

#### Vẽ tự do
1. Chọn **Draw Tool** (icon bút chì) hoặc `⌘ + D`
2. Tùy chỉnh:
   - **Màu**: Click vào color picker
   - **Độ dày**: Drag slider "Line Width"
3. Click và drag trên PDF để vẽ

#### Vẽ hình
1. Chọn tool:
   - **Rectangle** (`⌘ + R`): Hình chữ nhật
   - **Circle** (`⌘ + C`): Hình tròn
   - **Line** (`⌘ + L`): Đường thẳng
   - **Arrow**: Mũi tên
2. Click điểm bắt đầu và drag đến điểm kết thúc

#### Highlight text
1. Chọn **Highlight Tool** (`⌘ + H`)
2. Chọn màu highlight
3. Click và drag qua text cần highlight

### 4. Quản lý trang

#### Xem thumbnails
1. Click icon **sidebar** ở góc trên trái
2. Hoặc `⌘ + Option + T`
3. Sidebar sẽ hiện danh sách thumbnails của tất cả các trang

#### Xoay trang
**Cách 1: Context menu**
1. Right-click vào thumbnail trong sidebar
2. Chọn **"Rotate Left"** hoặc **"Rotate Right"**

**Cách 2: Keyboard shortcuts**
- `⌘ + Option + L`: Xoay trái 90°
- `⌘ + Option + R`: Xoay phải 90°

#### Xóa trang
1. Right-click vào thumbnail
2. Chọn **"Delete Page"**
3. Confirm (nếu có)

*Note: Không thể xóa nếu PDF chỉ có 1 trang*

#### Sao chép trang
1. Right-click vào thumbnail
2. Chọn **"Duplicate Page"**
3. Trang mới sẽ được thêm ngay sau trang hiện tại

### 5. Tìm kiếm

1. Click vào icon **Search** hoặc `⌘ + F`
2. Panel tìm kiếm sẽ mở ở bên phải
3. Nhập từ khóa cần tìm
4. Nhấn **Enter** hoặc click icon search
5. Kết quả sẽ hiện:
   - Số lượng kết quả
   - Danh sách các match với context
   - Page number
6. Navigate:
   - Click **↑** để đi đến kết quả trước
   - Click **↓** để đi đến kết quả sau
   - Hoặc click trực tiếp vào kết quả trong danh sách

### 6. Zoom và Navigation

#### Zoom
- **Zoom in**: `⌘ + +` hoặc click icon "+"
- **Zoom out**: `⌘ + -` hoặc click icon "-"
- **Actual size**: `⌘ + 0`
- **Fit to width**: Click icon fit

#### Navigate giữa các trang
- **Next page**: Nhấn `↓` hoặc scroll
- **Previous page**: Nhấn `↑` hoặc scroll
- **Go to page**: Click vào thumbnail trong sidebar

### 7. Undo/Redo

- **Undo**: `⌘ + Z` hoặc click icon undo
- **Redo**: `⌘ + Shift + Z` hoặc click icon redo

*Ứng dụng lưu toàn bộ history của các thao tác*

### 8. Lưu file

#### Save (ghi đè file gốc)
```
⌘ + S
```
Hoặc: File → Save

#### Save As (lưu thành file mới)
```
⌘ + Shift + S
```
1. Chọn vị trí lưu
2. Đặt tên file
3. Click **"Save"**

#### Export
```
⌘ + E
```
Export PDF với tùy chọn:
- Quality
- Compression
- Security settings (nếu có)

## 🔧 Settings

Mở Settings: `⌘ + ,`

### Tab General
- **Default Zoom Level**: Mức zoom mặc định khi mở file
- **Show thumbnails on open**: Tự động hiện sidebar thumbnails
- **Auto-save**: Tự động lưu khi chỉnh sửa

### Tab Tools
- **Default Tool**: Tool được chọn mặc định khi mở ứng dụng
- Có thể chọn: Select, Text, Draw, v.v.

### Tab About
- Thông tin phiên bản
- Credits
- Links

## ❗ Xử lý lỗi thường gặp

### Lỗi: "Code Signing Error"
**Nguyên nhân**: Chưa configure code signing

**Giải pháp**:
1. Mở project settings
2. Chọn tab "Signing & Capabilities"
3. Chọn team (Apple ID)
4. Hoặc chọn "Sign to Run Locally"

### Lỗi: "Cannot find PDFKit"
**Nguyên nhân**: Missing system frameworks

**Giải pháp**:
1. Clean build folder: `⌘ + Shift + K`
2. Rebuild: `⌘ + B`
3. Nếu vẫn lỗi, restart Xcode

### Lỗi: "The app cannot be opened"
**Nguyên nhân**: App chưa được notarized (khi phân phối)

**Giải pháp**:
1. Right-click vào app
2. Chọn "Open"
3. Confirm "Open anyway"

### Lỗi: PDF không mở được
**Nguyên nhân**: File PDF bị corrupt hoặc encrypted

**Giải pháp**:
1. Kiểm tra file PDF với Preview
2. Nếu file encrypted, cần password
3. Thử export lại từ nguồn gốc

### Ứng dụng chạy chậm
**Nguyên nhân**: PDF quá lớn hoặc nhiều annotations

**Giải pháp**:
1. Close các apps khác
2. Giảm zoom level
3. Tắt thumbnails sidebar nếu không cần
4. Restart ứng dụng

## 💡 Tips & Tricks

### 1. Workflow hiệu quả
- Học thuộc keyboard shortcuts thường dùng
- Dùng `⌘ + Tab` để switch giữa tools nhanh
- Enable auto-save để không mất dữ liệu

### 2. Chỉnh sửa nhanh
- Double-click vào annotation để edit
- Dùng `⌘ + D` để duplicate annotation
- Shift + Click để select nhiều annotations

### 3. Tổ chức tốt
- Đặt tên file có ý nghĩa
- Tạo folder riêng cho từng project
- Export regular backups

### 4. Performance
- Đóng thumbnails sidebar khi không dùng
- Zoom về 100% khi edit text
- Clear undo history nếu quá dài

## 📚 Resources

### Documentation
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [PDFKit Documentation](https://developer.apple.com/documentation/pdfkit)

### Tutorials
- [Building macOS Apps](https://developer.apple.com/tutorials/swiftui)
- [Working with PDFs](https://www.raywenderlich.com/5542-pdfkit-tutorial-getting-started)

### Community
- [Stack Overflow](https://stackoverflow.com/questions/tagged/pdfkit)
- [Apple Developer Forums](https://developer.apple.com/forums/)

## 🆘 Hỗ trợ

Nếu gặp vấn đề:
1. Kiểm tra phần "Xử lý lỗi thường gặp" ở trên
2. Tìm kiếm trên Google với error message
3. Tạo issue trên GitHub repository
4. Hỏi trên Stack Overflow

## 🎓 Học thêm

### Swift & SwiftUI
- [100 Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui)
- [Stanford CS193p](https://cs193p.sites.stanford.edu/)

### macOS Development
- [Developing for macOS](https://developer.apple.com/macos/)
- [AppKit Documentation](https://developer.apple.com/documentation/appkit)

---

**Chúc bạn sử dụng PDF Editor thành công! 🎉**
