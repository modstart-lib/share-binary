#!/bin/bash

set -e

# Function to update scrcpy
update_scrcpy() {
    echo "📱 [1/4] 正在更新 scrcpy..."
    
    # Get the latest scrcpy version from GitHub releases
    #SCRCPY_BASE="https://github.com/Genymobile/scrcpy"
    SCRCPY_BASE="https://github.com/modstart-lib/linkandroid-scrcpy"
    echo "  🔍 获取最新版本信息..."
    SCRCPY_VERSION=$(curl -sL "${SCRCPY_BASE}/releases/latest" | grep -oE 'tag/v[0-9.]+' | head -n1 | sed 's/tag\///')
    echo "  🎯 最新版本: $SCRCPY_VERSION"

    # download ${SCRCPY_BASE}/releases/download/v3.3.3/scrcpy-macos-aarch64-v3.3.3.tar.gz
    echo "  📦 下载 macOS ARM64 版本..."
    rm -rf scrcpy-macos-aarch64.tar.gz
    curl -L# -o scrcpy-macos-aarch64.tar.gz "${SCRCPY_BASE}/releases/download/${SCRCPY_VERSION}/scrcpy-macos-aarch64-${SCRCPY_VERSION}.tar.gz"
    rm -rf osx-arm64/scrcpy
    mkdir -p osx-arm64/scrcpy
    tar -xzf scrcpy-macos-aarch64.tar.gz -C osx-arm64/scrcpy --strip-components=1
    rm -rf scrcpy-macos-aarch64.tar.gz
    echo "  ✅ macOS ARM64 完成"

    # download ${SCRCPY_BASE}/releases/download/v3.3.3/scrcpy-macos-x86_64-v3.3.3.tar.gz
    echo "  📦 下载 macOS x86_64 版本..."
    rm -rf scrcpy-macos-x86_64.tar.gz
    curl -L# -o scrcpy-macos-x86_64.tar.gz "${SCRCPY_BASE}/releases/download/${SCRCPY_VERSION}/scrcpy-macos-x86_64-${SCRCPY_VERSION}.tar.gz"
    rm -rf osx-x86/scrcpy
    mkdir -p osx-x86/scrcpy
    tar -xzf scrcpy-macos-x86_64.tar.gz -C osx-x86/scrcpy --strip-components=1
    rm -rf scrcpy-macos-x86_64.tar.gz
    echo "  ✅ macOS x86_64 完成"

    # download https://github.com/Genymobile/scrcpy/releases/download/v3.3.3/scrcpy-win64-v3.3.3.zip
    echo "  📦 下载 Windows x86 版本..."
    rm -rf scrcpy-win64.zip
    curl -L# -o scrcpy-win64.zip "${SCRCPY_BASE}/releases/download/${SCRCPY_VERSION}/scrcpy-win64-${SCRCPY_VERSION}.zip"
    rm -rf win-x86/scrcpy
    mkdir -p win-x86/scrcpy
    unzip -q -j scrcpy-win64.zip -d win-x86/scrcpy/
    rm -rf scrcpy-win64.zip
    echo "  ✅ Windows x86 完成"

    # download ${SCRCPY_BASE}/releases/download/v3.3.3/scrcpy-linux-x86_64-v3.3.3.tar.gz
    echo "  📦 下载 Linux x86_64 版本..."
    rm -rf scrcpy-linux-x86_64.tar.gz
    curl -L# -o scrcpy-linux-x86_64.tar.gz "${SCRCPY_BASE}/releases/download/${SCRCPY_VERSION}/scrcpy-linux-x86_64-${SCRCPY_VERSION}.tar.gz"
    rm -rf linux-x86/scrcpy
    mkdir -p linux-x86/scrcpy
    tar -xzf scrcpy-linux-x86_64.tar.gz -C linux-x86/scrcpy --strip-components=1
    rm -rf scrcpy-linux-x86_64.tar.gz
    echo "  ✅ Linux x86_64 完成"

    # download ${SCRCPY_BASE}/releases/download/${SCRCPY_VERSION}/scrcpy-linux-aarch64-${SCRCPY_VERSION}.tar.gz
    echo "  📦 下载 Linux ARM64 版本..."
    rm -rf scrcpy-linux-aarch64.tar.gz
    curl -L# -o scrcpy-linux-aarch64.tar.gz "${SCRCPY_BASE}/releases/download/${SCRCPY_VERSION}/scrcpy-linux-aarch64-${SCRCPY_VERSION}.tar.gz"
    rm -rf linux-arm64/scrcpy
    mkdir -p linux-arm64/scrcpy
    tar -xzf scrcpy-linux-aarch64.tar.gz -C linux-arm64/scrcpy --strip-components=1
    rm -rf scrcpy-linux-aarch64.tar.gz
    echo "  ✅ Linux ARM64 完成"
    
    echo "✅ scrcpy 更新完成！"
}

# Function to update ffmpeg
update_ffmpeg() {
    echo "🎬 [2/4] 正在更新 ffmpeg..."
    
    # macOS arm64
    echo "  📦 下载 macOS ARM64 版本..."
    curl -L# -o osx-arm64/ffmpeg.7z "https://evermeet.cx/ffmpeg/getrelease/ffmpeg/7z"
    7z e osx-arm64/ffmpeg.7z -oosx-arm64 -y > /dev/null
    rm -f osx-arm64/ffmpeg.7z
    chmod +x osx-arm64/ffmpeg
    echo "  ✅ macOS ARM64 完成"
    
    # macOS x86_64
    echo "  📦 下载 macOS x86_64 版本..."
    curl -L# -o osx-x86/ffmpeg.7z "https://evermeet.cx/ffmpeg/getrelease/ffmpeg/7z"
    7z e osx-x86/ffmpeg.7z -oosx-x86 -y > /dev/null
    rm -f osx-x86/ffmpeg.7z
    chmod +x osx-x86/ffmpeg
    echo "  ✅ macOS x86_64 完成"
    
    # Linux x86_64
    echo "  📦 下载 Linux x86_64 版本..."
    FFMPEG_LINUX_URL=$(curl -s https://johnvansickle.com/ffmpeg/ | grep -oP 'https://[^"]+ffmpeg-release-amd64-static\.tar\.xz' | head -n1)
    curl -L# -o ffmpeg-linux-x86_64.tar.xz "$FFMPEG_LINUX_URL"
    tar -xf ffmpeg-linux-x86_64.tar.xz
    FFMPEG_DIR=$(tar -tf ffmpeg-linux-x86_64.tar.xz | head -n1 | cut -d'/' -f1)
    cp "$FFMPEG_DIR/ffmpeg" linux-x86/ffmpeg
    rm -rf ffmpeg-linux-x86_64.tar.xz "$FFMPEG_DIR"
    chmod +x linux-x86/ffmpeg
    echo "  ✅ Linux x86_64 完成"
    
    # Linux arm64
    echo "  📦 下载 Linux ARM64 版本..."
    FFMPEG_LINUX_ARM_URL=$(curl -s https://johnvansickle.com/ffmpeg/ | grep -oP 'https://[^"]+ffmpeg-release-arm64-static\.tar\.xz' | head -n1)
    curl -L# -o ffmpeg-linux-arm64.tar.xz "$FFMPEG_LINUX_ARM_URL"
    tar -xf ffmpeg-linux-arm64.tar.xz
    FFMPEG_ARM_DIR=$(tar -tf ffmpeg-linux-arm64.tar.xz | head -n1 | cut -d'/' -f1)
    cp "$FFMPEG_ARM_DIR/ffmpeg" linux-arm64/ffmpeg
    rm -rf ffmpeg-linux-arm64.tar.xz "$FFMPEG_ARM_DIR"
    chmod +x linux-arm64/ffmpeg
    echo "  ✅ Linux ARM64 完成"
    
    echo "✅ ffmpeg 更新完成！"
}

# Function to update ffprobe
update_ffprobe() {
    echo "🔎 [3/4] 正在更新 ffprobe..."
    
    # macOS arm64
    echo "  📦 下载 macOS ARM64 版本..."
    curl -L# -o osx-arm64/ffprobe.7z "https://evermeet.cx/ffmpeg/getrelease/ffprobe/7z"
    7z e osx-arm64/ffprobe.7z -oosx-arm64 -y > /dev/null
    rm -f osx-arm64/ffprobe.7z
    chmod +x osx-arm64/ffprobe
    echo "  ✅ macOS ARM64 完成"
    
    # macOS x86_64
    echo "  📦 下载 macOS x86_64 版本..."
    curl -L# -o osx-x86/ffprobe.7z "https://evermeet.cx/ffmpeg/getrelease/ffprobe/7z"
    7z e osx-x86/ffprobe.7z -oosx-x86 -y > /dev/null
    rm -f osx-x86/ffprobe.7z
    chmod +x osx-x86/ffprobe
    echo "  ✅ macOS x86_64 完成"
    
    # Linux x86_64
    echo "  📦 下载 Linux x86_64 版本..."
    FFMPEG_LINUX_URL=$(curl -s https://johnvansickle.com/ffmpeg/ | grep -oP 'https://[^"]+ffmpeg-release-amd64-static\.tar\.xz' | head -n1)
    curl -L# -o ffmpeg-linux-x86_64.tar.xz "$FFMPEG_LINUX_URL"
    tar -xf ffmpeg-linux-x86_64.tar.xz
    FFMPEG_DIR=$(tar -tf ffmpeg-linux-x86_64.tar.xz | head -n1 | cut -d'/' -f1)
    cp "$FFMPEG_DIR/ffprobe" linux-x86/ffprobe
    rm -rf ffmpeg-linux-x86_64.tar.xz "$FFMPEG_DIR"
    chmod +x linux-x86/ffprobe
    echo "  ✅ Linux x86_64 完成"
    
    # Linux arm64
    echo "  📦 下载 Linux ARM64 版本..."
    FFMPEG_LINUX_ARM_URL=$(curl -s https://johnvansickle.com/ffmpeg/ | grep -oP 'https://[^"]+ffmpeg-release-arm64-static\.tar\.xz' | head -n1)
    curl -L# -o ffmpeg-linux-arm64.tar.xz "$FFMPEG_LINUX_ARM_URL"
    tar -xf ffmpeg-linux-arm64.tar.xz
    FFMPEG_ARM_DIR=$(tar -tf ffmpeg-linux-arm64.tar.xz | head -n1 | cut -d'/' -f1)
    cp "$FFMPEG_ARM_DIR/ffprobe" linux-arm64/ffprobe
    rm -rf ffmpeg-linux-arm64.tar.xz "$FFMPEG_ARM_DIR"
    chmod +x linux-arm64/ffprobe
    echo "  ✅ Linux ARM64 完成"
    
    echo "✅ ffprobe 更新完成！"
}

# Parse command line arguments
COMPONENT="${1:-}"

case "$COMPONENT" in
    "")
        echo "Usage: $0 {all|scrcpy|ffmpeg|ffprobe}"
        echo "  all      - Update all components"
        echo "  scrcpy   - Update scrcpy only"
        echo "  ffmpeg   - Update ffmpeg only"
        echo "  ffprobe  - Update ffprobe only"
        exit 0
        ;;
    all)
        update_scrcpy
        update_ffmpeg
        update_ffprobe
        ;;
    scrcpy)
        update_scrcpy
        ;;
    ffmpeg)
        update_ffmpeg
        ;;
    ffprobe)
        update_ffprobe
        ;;
    *)
        echo "Usage: $0 {all|scrcpy|ffmpeg|ffprobe}"
        echo "  all      - Update all components"
        echo "  scrcpy   - Update scrcpy only"
        echo "  ffmpeg   - Update ffmpeg only"
        echo "  ffprobe  - Update ffprobe only"
        exit 1
        ;;
esac

echo ""
echo "========================================"
echo "🎉 所有更新已完成！"
echo "========================================"
