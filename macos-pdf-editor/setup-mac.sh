#!/bin/bash

# PDF Editor - One-Click Setup Script for Mac
# Copy và chạy script này trên Mac của bạn

echo "🚀 Setting up PDF Editor..."
echo ""

# Create project directory
PROJECT_DIR="$HOME/Desktop/PDFEditor"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

echo "📂 Created project at: $PROJECT_DIR"
echo ""
echo "⬇️  Downloading from GitHub..."
echo ""

# Clone from GitHub
if command -v git &> /dev/null; then
    git clone https://github.com/leeberlin/claudekit-skills.git temp
    mv temp/macos-pdf-editor/* .
    rm -rf temp
    echo "✅ Downloaded successfully!"
else
    echo "❌ Git not found. Please install git or download manually:"
    echo "   https://github.com/leeberlin/claudekit-skills"
    exit 1
fi

echo ""
echo "🔧 Opening Xcode..."
open PDFEditor.xcodeproj

echo ""
echo "✅ Done! Next steps:"
echo "  1. Wait for Xcode to open"
echo "  2. Select 'My Mac' as target"
echo "  3. Press ⌘ + R to build and run"
echo ""
echo "📖 For help, see RUN_LOCAL.md"
