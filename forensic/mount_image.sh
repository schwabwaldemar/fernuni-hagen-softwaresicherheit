#!/bin/bash

# This script takes a .hdd image file as input, creates a new .dmg image file, and copies the contents of the .hdd image to the new .dmg image using the 'dd' command.

# Waldemar Schwab
# BSD 3-Clause License

# Check if an input argument was provided
if [ -z "$1" ]; then
    echo "Error: No file path provided. Please provide a file path as an argument."
    exit 1
fi

# The script takes one argument: the filepath to the .hdd image
input_file="$1"

echo "Starting the script to process the .hdd image at $input_file..."

# Function to check if the file has a .hdd extension
check_extension() {
    echo "Checking the file extension of $input_file..."
    if [[ "$input_file" =~ \.hdd$ ]]; then
        echo "File extension is .hdd. Proceeding..."
    else
        echo "Error: File does not have a .hdd extension. The file must end in '.hdd' to proceed."
        exit 1
    fi
}

# Function to check the file type
check_file_type() {
    echo "Verifying the file type with 'file' command..."
    filetype=$(file "$input_file")
    echo "File type of $input_file: $filetype"
    if [[ "$filetype" =~ disk ]]; then
        echo "File type is appropriate for copying. Proceeding..."
    else
        echo "Error: File type is not appropriate for copying. Expected a disk image."
        exit 2
    fi
}

# Function to copy the image using dd
copy_image() {
    # Determining the size of the input image
    echo "Calculating the size of $input_file..."
    filesize=$(stat -f "%z" "$input_file")

    echo "Formatting the file size for better readability..."
    # Print filesize more readable
    if [ $filesize -gt 1048576 ]; then
        filesize_print=$(echo "scale=2; $filesize / 1048576" | bc)
        filesize_print="$filesize_print MB"
    else
        filesize_print=$(echo "scale=2; $filesize / 1024" | bc)
        filesize_print="$filesize_print KB"
    fi

    echo "Size of the input file: $filesize_print"

    # Get user input for new image name
    new_image_name=""
    while [[ -z "$new_image_name" ]]; do
        echo "Please enter a name for the new image (without extension, '*.dmg' will be added automatically):"
        read new_image_name
    done

    # Creating a new .dmg file
    new_image="${new_image_name}.dmg"
    echo "Creating a new disk image with the name '$new_image'..."
    # FAT32 only - because the course is fine wirh FAT32 - feel free to extend the script to support more formats
    hdiutil create -size ${filesize}b -fs HFS+ -volname "New Image" -ov "$new_image"

    # Check if the new image was created successfully
    if [ $? -ne 0 ]; then
        echo "Error creating the new image. Please see error log for details."
        echo "Filesize: ${filesize}"
        exit 3
    fi

    echo "New image created successfully. Image path: $new_image"
    
    # Attaching the new image and getting the device identifier
    echo "Attaching the new disk image..."
    device=$(hdiutil attach "$new_image" -nomount)
    echo "Disk image attached. Device identifier: $device"

    # Unmount the device to prepare for dd
    echo "Unmounting the disk $device to prepare for safe copying..."
    diskutil unmountDisk "$device"
    
    echo "Starting the copy process using 'dd'..."
    dd if="$input_file" of="$device" bs=1m

    if [ $? -ne 0 ]; then
        echo "Error during copying. See error log for details."
    else
        echo "Copy successful. The contents of $input_file have been copied to $device."
    fi
}

# Script execution flow
check_extension
check_file_type
copy_image
