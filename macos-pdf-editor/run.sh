#!/bin/bash

# PDF Editor - Quick Launch Script
# This script opens the project in Xcode

echo "🚀 PDF Editor - Quick Launch"
echo "=============================="
echo ""

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Error: Xcode is not installed!"
    echo ""
    echo "Please install Xcode from:"
    echo "  - App Store: https://apps.apple.com/app/xcode/id497799835"
    echo "  - Or: https://developer.apple.com/xcode/"
    echo ""
    exit 1
fi

# Check Xcode version
XCODE_VERSION=$(xcodebuild -version | head -n 1 | awk '{print $2}')
echo "✅ Xcode version: $XCODE_VERSION"

# Check macOS version
MACOS_VERSION=$(sw_vers -productVersion)
echo "✅ macOS version: $MACOS_VERSION"
echo ""

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_PATH="$SCRIPT_DIR/PDFEditor.xcodeproj"

# Check if project exists
if [ ! -d "$PROJECT_PATH" ]; then
    echo "❌ Error: PDFEditor.xcodeproj not found!"
    echo "Expected location: $PROJECT_PATH"
    exit 1
fi

echo "📂 Project found: $PROJECT_PATH"
echo ""
echo "Opening Xcode..."
echo ""
echo "📝 Next steps:"
echo "  1. Wait for Xcode to open"
echo "  2. Select 'My Mac' as target (top-left)"
echo "  3. Press ⌘ + R to build and run"
echo ""
echo "💡 Tip: First build takes 2-5 minutes"
echo ""

# Open the project
open "$PROJECT_PATH"

echo "✅ Done! Xcode should open shortly."
echo ""
echo "📖 For detailed instructions, see RUN_LOCAL.md"
