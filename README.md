# Cross-Platform Folder Statistics Scripts

A set of native scripts for **macOS**, **Linux**, and **Windows** that recursively analyze a directory or drive, providing detailed statistics about folder sizes, file counts, and more. Now includes a native **Objective-C command-line tool for macOS**.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Supported Platforms](#supported-platforms)
- [Getting Started](#getting-started)
    - [macOS \& Linux (Bash)](#macos--linux-bash)
    - [macOS (Objective-C)](#macos-objective-c)
    - [Windows (PowerShell)](#windows-powershell)
- [Usage Examples](#usage-examples)
- [Output](#output)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)


## Overview

This project provides platform-native scripts to analyze any folder or drive, including external storage, and report:

- The size of each folder and subfolder (recursively)
- The number of files in the main folder and all subfolders
- The size of the largest file
- The largest folder by size
- Full recursion through all subfolders

No third-party dependencies required—just use your system’s built-in scripting tools.

## Features

- **Recursive analysis** of all subfolders
- **Folder and file statistics**: sizes, counts, largest file/folder
- **Native scripts** for each OS (Bash for macOS/Linux, PowerShell for Windows, Objective-C for macOS)
- **Easy to use**: just run the script and specify your target directory


## Supported Platforms

| Platform | Script Language | Filename |
| :-- | :-- | :-- |
| macOS | Bash | `folder_stats.sh` |
| macOS | Objective-C | `folder_stats.m` |
| Linux | Bash | `folder_stats.sh` |
| Windows | PowerShell | `FolderStats.ps1` |

## Getting Started

### macOS \& Linux (Bash)

1. **Download** `folder_stats.sh` to your machine.
2. **Make it executable**:

```bash
chmod +x folder_stats.sh
```

3. **Run the script**:

```bash
./folder_stats.sh /path/to/your/folder
```


### macOS (Objective-C)

1. **Download** `folder_stats.m` to your machine.
2. **Open Terminal** and navigate to the file's directory.
3. **Compile:**

```bash
clang -framework Foundation -o folder_stats folder_stats.m
```

4. **Run:**

```bash
./folder_stats /path/to/your/folder
```

    - If you omit the path, it analyzes the current directory.

### Windows (PowerShell)

1. **Download** `FolderStats.ps1`.
2. **Open PowerShell** and navigate to the script’s directory.
3. **Run the script**:

```powershell
.\FolderStats.ps1 -Path "C:\Path\To\Your\Folder"
```


## Usage Examples

### Bash (macOS/Linux)

```bash
./folder_stats.sh /Volumes/SanDisk
```


### Objective-C (macOS)

```bash
./folder_stats /Volumes/SanDisk
```


### PowerShell (Windows)

```powershell
.\FolderStats.ps1 -Path "D:\ExternalDrive"
```


## Output

The scripts will display:

- **Folder sizes (recursive):** List of all folders and their sizes
- **Number of files in main folder:** Count of files (not recursive)
- **Total number of files (recursive):** Count of all files in all subfolders
- **Largest file:** Path and size of the largest file
- **Largest folder:** Path and size of the largest folder


## Troubleshooting

If you see errors like `No such file or directory`:

- **Check the path:** Make sure the folder or drive is connected and mounted.
- **On macOS/Linux:** Use `ls /Volumes/` to confirm the correct mount point.
- **On Windows:** Ensure the drive letter is correct and accessible.
- **For external drives:** If not detected, check cables, try another port, or use Disk Utility (macOS) or Disk Management (Windows) to mount or repair the drive.


## Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements, bug fixes, or new features.

## License

This project is licensed under the MIT License.