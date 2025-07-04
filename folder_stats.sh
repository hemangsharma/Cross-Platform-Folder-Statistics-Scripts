#!/bin/bash

TARGET="${1:-.}"

echo "Analyzing: $TARGET"
echo

# 1. Size of each folder and subfolder
echo "Folder sizes (recursive):"
du -h "$TARGET"

echo
# 2. Number of files in the main folder (not recursive)
echo -n "Number of files in $TARGET (not recursive): "
find "$TARGET" -maxdepth 1 -type f | wc -l

# 3. Number of files in all subfolders (recursive)
echo -n "Total number of files (recursive): "
find "$TARGET" -type f | wc -l

echo
# 4. Largest file (recursive)
echo "Largest file:"
find "$TARGET" -type f -exec du -h {} + | sort -hr | head -n 1

echo
# 5. Largest folder (recursive)
echo "Largest folder:"
du -h "$TARGET" | sort -hr | head -n 2 | tail -n 1