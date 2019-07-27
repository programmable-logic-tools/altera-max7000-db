#!/bin/bash

# Stop on error
set -e

# Where to store the generated HTML
TARGET_FOLDER="../altera-max7000-db.gh-pages"

# Clear the target folder
here=$(pwd)
cd "$TARGET_FOLDER"
rm -f epm*.html *.css
git pull
cd "$here"

# Generate new content
echo "Generating HTML..."
./epm7032s.py

# Copy content to target folder
echo "Copying output to branch gh-pages..."
cp -v epm*.html *.css "$TARGET_FOLDER/"

# Create a git commit
hash=$(git rev-parse --short HEAD)
cd "$TARGET_FOLDER"
git add -A
git commit -m "Generated from commit $hash"

if [ "$1" == "--push" ]; then
	git push
fi

