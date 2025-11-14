# ✅ Checklist chạy PDF Editor Local

## Chuẩn bị (Chỉ cần làm 1 lần)

- [ ] **Có Mac với macOS 13.0+**
  ```bash
  sw_vers  # Kiểm tra version
  ```

- [ ] **Đã cài Xcode 15.0+**
  ```bash
  xcodebuild -version  # Kiểm tra
  ```
  - ❌ Chưa có? → Mở App Store, tìm "Xcode", cài đặt

- [ ] **Đã cài Command Line Tools**
  ```bash
  xcode-select --install
  ```

- [ ] **Có project code**
  - Option 1: Clone từ GitHub
  - Option 2: Đã có trong `~/claudekit-skills/macos-pdf-editor`

---

## Chạy app (Mỗi lần)

### Cách 1: Dùng Script (Nhanh nhất! 🚀)

```bash
cd ~/claudekit-skills/macos-pdf-editor
./run.sh
```

- [ ] Chạy script → Xcode sẽ tự mở
- [ ] Đợi Xcode load project
- [ ] Chọn **"My Mac"** ở dropdown góc trên trái
- [ ] Nhấn **⌘ + R**
- [ ] Đợi build (2-5 phút lần đầu)
- [ ] App launch! 🎉

### Cách 2: Manual (Step by step)

- [ ] **Bước 1: Mở Terminal**
  ```bash
  cd ~/claudekit-skills/macos-pdf-editor
  ```

- [ ] **Bước 2: Mở Xcode**
  ```bash
  open PDFEditor.xcodeproj
  ```

- [ ] **Bước 3: Configure (Lần đầu tiên)**
  - Click project "PDFEditor" ở sidebar trái
  - Chọn tab "Signing & Capabilities"
  - Chọn Team (Apple ID của bạn)
  - Nếu không có, chọn "Sign to Run Locally"

- [ ] **Bước 4: Select Target**
  - Góc trên trái, click dropdown
  - Chọn "My Mac"

- [ ] **Bước 5: Run!**
  - Nhấn ⌘ + R
  - Hoặc click nút ▶️ Play
  - Đợi build...

- [ ] **Bước 6: Test App**
  - App sẽ launch
  - Thấy "No PDF Open"
  - Click "Open PDF File"
  - Chọn 1 file PDF bất kỳ
  - Test các tools!

---

## Xác nhận app chạy OK

- [ ] App launch không có lỗi
- [ ] Có thể mở file PDF
- [ ] Text tool hoạt động (⌘ + T)
- [ ] Draw tool hoạt động (⌘ + D)
- [ ] Zoom in/out (⌘ + +/-)
- [ ] Undo/Redo (⌘ + Z)
- [ ] Save file (⌘ + S)

**Nếu tất cả ✅ → Thành công!** 🎉

---

## Nếu gặp lỗi

### Lỗi: "Xcode not installed"
```bash
# Cài Xcode từ App Store
open -a "App Store"
# Hoặc: https://developer.apple.com/xcode/
```

### Lỗi: "Code signing error"
1. Mở Xcode
2. Project settings → "Signing & Capabilities"
3. Chọn team/Apple ID
4. Hoặc enable "Sign to Run Locally"

### Lỗi: "Build failed"
```bash
# Clean build folder
# Trong Xcode: ⌘ + Shift + K
# Rồi build lại: ⌘ + R
```

### Lỗi khác
- Xem file **RUN_LOCAL.md** → Phần "Xử lý lỗi"
- Hoặc Google error message

---

## Time estimate

| Task | First time | After |
|------|------------|-------|
| Cài Xcode | 30-40 phút | - |
| Setup project | 5 phút | - |
| Build | 2-5 phút | 30 giây |
| **Total** | **~45 phút** | **~1 phút** |

---

## 🎯 TL;DR - Shortest path

Nếu đã có Xcode:

```bash
cd ~/claudekit-skills/macos-pdf-editor
./run.sh
# Rồi nhấn ⌘ + R trong Xcode
```

**That's it!** ✨

---

## 📚 Tài liệu thêm

- 📖 **RUN_LOCAL.md** - Hướng dẫn chi tiết từng bước
- ⚡ **QUICKSTART.md** - Quick start guide
- 🇻🇳 **SETUP_VI.md** - Setup guide tiếng Việt đầy đủ
- 📊 **PROJECT_SUMMARY.md** - Technical overview

---

**Good luck! 🚀**
