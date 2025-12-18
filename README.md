# 🚀 share-binary

跨平台二进制工具集合，便于在不同操作系统和架构下分发和使用常用命令行工具。

## 📁 目录结构

```
update.sh
linux-arm64/
linux-x86/
osx-arm64/
osx-x86/
win-x86/
```

各平台文件夹下包含对应架构的二进制文件，例如 `ffmpeg`、`ffprobe`、`scrcpy` 及相关依赖。

- 🐧 `linux-arm64/`、`linux-x86/`：Linux 平台二进制
- 🍎 `osx-arm64/`、`osx-x86/`：macOS 平台二进制
- 🪟 `win-x86/`：Windows 平台二进制

## 🔧 主要内容

- 🎬 `ffmpeg` / `ffprobe`：音视频处理工具
- 📱 `scrcpy`：安卓设备投屏与控制工具
- 🛠️ `adb`：安卓调试桥

## 📝 使用方法

1. 选择对应平台和架构的文件夹
2. 直接运行所需的二进制文件
3. Windows 用户可使用批处理脚本快速启动

## ⬆️ 更新

运行 `update.sh` 可自动更新相关二进制文件（需配置好下载源和权限）。

## 📄 许可

请根据各工具的官方许可协议使用本项目中的二进制文件。
