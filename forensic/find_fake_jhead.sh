#!/bin/bash

# Directory to scan
search_directory="$1"

# Extension to check against what they are posing as (e.g., files posing as .odt)
fake_extension="odt"

# Check if search directory is provided
if [ -z "$search_directory" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Check if jhead is installed
if ! command -v jhead &> /dev/null
then
    echo "jhead could not be found, please install it to use this script."
    exit 1
fi

echo "Scanning directory '$search_directory' for files with a .${fake_extension} extension that are actually JPEG images..."

# Find files with the given fake extension and check if they are JPEGs
find "$search_directory" -type f -name "*.$fake_extension" -print0 | while IFS= read -r -d $'\0' file; do
    if jhead "$file" &> /dev/null; then
        echo "Mismatch found: '$file' has a .$fake_extension extension but is a JPEG image."
    fi
done

echo "Scan complete."
