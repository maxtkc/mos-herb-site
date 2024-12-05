#!/bin/bash
# Loop through all assets/img/file.jpg and create assets/images/webp/file.webp and update references

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
REPO_DIR=$( dirname "$SCRIPT_DIR" )
IMG_DIR="$REPO_DIR/assets/images"

# Loop through each image
for file in "$IMG_DIR"/*.{jpg,jpeg,png};
do
    full_filename=$(basename -- "$file");
    filename="${full_filename%.*}"
    full_webp_path="$IMG_DIR/webp/$filename.webp"

    if [ ! -f "$full_webp_path" ]
    then
        # Fix the rotation
        tmpf="$(mktemp).jpg"
        convert "$file" -auto-orient "$tmpf";
        # Convert to webp
        cwebp "$tmpf" -o "$full_webp_path";
    fi
    # Replace instances of the image in _posts
    gawk -i inplace "{gsub(/assets\/images\/$full_filename/,\"assets/images/webp/$filename.webp\"); gsub(/^image:.*$full_filename.*$/,\"image: 'webp/$filename.webp'\");}1" "$REPO_DIR"/*.md;
done
