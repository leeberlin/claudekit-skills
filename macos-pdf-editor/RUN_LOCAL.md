# 🚀 Chạy PDF Editor Local - Hướng dẫn chi tiết

## ✅ Bước 1: Kiểm tra yêu cầu

### Kiểm tra macOS version:
```bash
sw_vers
```
**Cần**: macOS 13.0 (Ventura) trở lên

### Kiểm tra Xcode đã cài chưa:
```bash
xcodebuild -version
```
**Cần**: Xcode 15.0 trở lên

**Nếu chưa có Xcode:**
```bash
# Mở App Store
open -a "App Store"
# Tìm "Xcode" và cài đặt (mất 30-40 phút)
```

Hoặc download từ: https://developer.apple.com/xcode/

---

## 📦 Bước 2: Clone/Download Project

### Cách 1: Nếu đã clone repo này
```bash
cd ~/claudekit-skills/macos-pdf-editor
```

### Cách 2: Clone fresh từ GitHub
```bash
cd ~/Desktop
git clone https://github.com/leeberlin/claudekit-skills.git
cd claudekit-skills/macos-pdf-editor
```

### Cách 3: Copy từ folder hiện tại
```bash
# Nếu bạn đang ở folder claudekit-skills
cd macos-pdf-editor
```

---

## 🔧 Bước 3: Mở Project trong Xcode

```bash
# Từ terminal:
open PDFEditor.xcodeproj
```

**Hoặc:**
1. Mở **Finder**
2. Navigate đến folder `macos-pdf-editor`
3. Double-click vào **`PDFEditor.xcodeproj`**

![Xcode Project](https://via.placeholder.com/800x400?text=Double+click+PDFEditor.xcodeproj)

---

## ⚙️ Bước 4: Configure Code Signing

Khi Xcode mở lên:

### 4.1: Chọn Project
1. Click vào **"PDFEditor"** ở sidebar bên trái (file màu xanh)
2. Đảm bảo tab **"PROJECT"** → **"PDFEditor"** được chọn

### 4.2: Configure Signing
1. Click vào tab **"Signing & Capabilities"**
2. Trong phần **"Signing"**:
   - **Team**: Chọn Apple ID của bạn
   - Nếu chưa có, click **"Add Account..."** và đăng nhập Apple ID
   - Hoặc chọn **"Sign to Run Locally"** (cho development)

### 4.3: Bundle Identifier (nếu bị conflict)
Nếu gặp lỗi "Bundle identifier already exists":
```
Đổi Bundle Identifier từ:
com.pdfeditor.macos
→
com.YOURNAME.pdfeditor
```

---

## 🎯 Bước 5: Select Target Device

Ở góc trên bên trái của Xcode:
1. Click vào dropdown hiện **"PDFEditor"**
2. Chọn **"My Mac"** (hoặc tên Mac của bạn)

![Select My Mac](https://via.placeholder.com/400x100?text=Select+My+Mac)

---

## ▶️ Bước 6: Build & Run

### Cách 1: Keyboard Shortcut (Nhanh nhất!)
```
⌘ + R
```

### Cách 2: Menu
```
Product → Run
```

### Cách 3: Button
Click nút **▶️ Play** ở góc trên trái

---

## ⏱️ Bước 7: Đợi Build

Lần đầu tiên build sẽ mất **2-5 phút**:
- Xcode sẽ compile tất cả Swift files
- Bạn sẽ thấy progress bar ở trên
- Đợi đến khi thấy **"Build Succeeded"**

Các lần sau chỉ mất **10-30 giây**

---

## 🎉 Bước 8: Sử dụng App!

Khi build xong:
1. App sẽ tự động launch
2. Bạn sẽ thấy màn hình **"No PDF Open"**
3. Click **"Open PDF File"** để chọn PDF
4. Bắt đầu edit!

---

## 🐛 Xử lý lỗi thường gặp

### Lỗi 1: "Command line tools are not installed"
```bash
xcode-select --install
```
Click **"Install"** khi popup hiện lên

### Lỗi 2: "Signing for PDFEditor requires a development team"
**Giải pháp:**
1. Go to **Signing & Capabilities**
2. Uncheck **"Automatically manage signing"**
3. Check lại
4. Chọn team từ dropdown

### Lỗi 3: "Build failed" với nhiều errors
**Giải pháp:**
```bash
# Clean build folder
⌘ + Shift + K

# Hoặc:
Product → Clean Build Folder

# Rồi build lại:
⌘ + B
```

### Lỗi 4: "The operation couldn't be completed"
**Giải pháp:**
1. Quit Xcode hoàn toàn
2. Xóa derived data:
```bash
rm -rf ~/Library/Developer/Xcode/DerivedData
```
3. Mở lại project và build

### Lỗi 5: "No such module 'PDFKit'"
**Giải pháp:**
PDFKit là built-in, chỉ cần:
1. Đảm bảo Deployment Target là macOS 13.0+
2. Clean và rebuild

---

## 📍 Tìm file .app sau khi build

Nếu muốn tìm file .app đã build:
```bash
# Trong terminal:
open ~/Library/Developer/Xcode/DerivedData/

# Tìm folder PDFEditor-xxx/Build/Products/Debug/
# File PDFEditor.app sẽ ở đây
```

Hoặc trong Xcode:
1. **Product → Show Build Folder in Finder**

---

## 🔄 Workflow Development

### Run app:
```
⌘ + R
```

### Stop app:
```
⌘ + .
```

### Build without running:
```
⌘ + B
```

### Clean build:
```
⌘ + Shift + K
```

### Run with debugging:
App sẽ tự động attach debugger khi run với ⌘ + R

---

## 🎯 Quick Test Checklist

Sau khi app launch, test các tính năng:

- [ ] Open PDF file (⌘ + O)
- [ ] Click Text tool (⌘ + T)
- [ ] Click on PDF để add text
- [ ] Try Draw tool (⌘ + D)
- [ ] Drag to draw something
- [ ] Try Highlight (⌘ + H)
- [ ] Undo (⌘ + Z)
- [ ] Redo (⌘ + Shift + Z)
- [ ] Zoom in/out (⌘ + +/-)
- [ ] Save file (⌘ + S)

Nếu tất cả work → **Thành công!** 🎉

---

## 🚀 Build Release Version (Optional)

Nếu muốn build version để chia sẻ:

### 1. Archive:
```
Product → Archive
```

### 2. Export:
1. Window sẽ mở với Archives
2. Click **"Distribute App"**
3. Chọn **"Copy App"**
4. Chọn folder để save
5. Click **"Export"**

File .app sẽ được export!

---

## 💡 Tips

### 1. Auto-reload khi sửa code:
Xcode tự động rebuild khi bạn sửa code và nhấn ⌘ + R

### 2. Debug Console:
Xem logs ở:
```
View → Debug Area → Show Debug Area
```
Hoặc: `⌘ + Shift + Y`

### 3. Breakpoints:
Click vào dòng code để set breakpoint
App sẽ pause ở đó khi run

### 4. Hot Reload (SwiftUI):
- Không cần rebuild toàn bộ
- Chỉ cần chỉnh UI trong SwiftUI preview

### 5. Live Preview:
Trong file SwiftUI, click:
```
Resume (canvas icon) ở góc phải trên
```
Sẽ thấy preview live của UI!

---

## 📱 Alternative: Run from Command Line

```bash
# Build
xcodebuild -scheme PDFEditor -configuration Debug build

# Run (sau khi build)
open ~/Library/Developer/Xcode/DerivedData/PDFEditor-*/Build/Products/Debug/PDFEditor.app
```

---

## ✅ Summary

**TL;DR - Chạy trong 3 bước:**

```bash
# 1. Mở project
cd ~/claudekit-skills/macos-pdf-editor
open PDFEditor.xcodeproj

# 2. Trong Xcode: Chọn "My Mac" ở góc trên trái

# 3. Nhấn ⌘ + R
```

**Done!** 🎉

---

## 🆘 Cần help?

Nếu gặp vấn đề:
1. Check phần "Xử lý lỗi" ở trên
2. Google error message
3. Check Xcode logs (⌘ + Shift + Y)
4. Clean build và thử lại

---

**Good luck! 🚀**
