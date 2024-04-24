#!/bin/bash

# Directory to scan
search_directory="$1"

# Check if search directory is provided
if [ -z "$search_directory" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Check if 'file' command is available
if ! command -v file &> /dev/null
then
    echo "'file' command could not be found, please install it to use this script."
    exit 1
fi

echo "Scanning directory '$search_directory' for files with mismatched content types..."

# Find all files and check their MIME type against their extension
find "$search_directory" -type f -print0 | while IFS= read -r -d $'\0' file; do
    # Get the MIME type of the file
    mimetype=$(file --mime-type -b "$file")
    
    # Extract the extension of the file
    extension="${file##*.}"

    # Define expected MIME type based on file extension
    # This list can be expanded as needed
    case "$extension" in
        jpg|jpeg)
            expected_mime="image/jpeg"
            ;;
        png)
            expected_mime="image/png"
            ;;
        gif)
            expected_mime="image/gif"
            ;;
        txt)
            expected_mime="text/plain"
            ;;
        pdf)
            expected_mime="application/pdf"
            ;;
        odt)
            expected_mime="application/vnd.oasis.opendocument.text"
            ;;
        *)
            expected_mime=""
            ;;
    esac

    # Check if the detected MIME type matches the expected MIME type
    if [[ -n "$expected_mime" && "$mimetype" != "$expected_mime" ]]; then
        echo "Mismatch found: '$file' has extension .$extension but MIME type is $mimetype."
    elif [[ -z "$expected_mime" ]]; then
        echo "No expected MIME type for .$extension, detected MIME type is $mimetype."
    fi
done

echo "Scan complete."
