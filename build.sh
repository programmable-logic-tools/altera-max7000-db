#!/bin/bash

# Stop on error
set -e

# Where to store the generated HTML
TARGET_FOLDER="../altera-max7000-db.gh-pages"

# Clear the target folder
here=$(pwd)
cd "$TARGET_FOLDER"
rm -f *.html *.css
cd "$here"

# Generate new content
./epm7032s.py

# Copy content to target folder
cp -v *.html *.css "$TARGET_FOLDER/"

# Create a git commit
hash=$(git rev-parse --short HEAD)
cd "$TARGET_FOLDER"
git add -A
git commit -m "Generated using commit $hash"

