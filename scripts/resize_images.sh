#!/bin/bash
# Generate resized images for all non-feature images and update references

SIZE="480x480"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
REPO_DIR=$( dirname "$SCRIPT_DIR" )
IMG_DIR="$REPO_DIR/assets/images"
RESIZED_DIR="$IMG_DIR/resized_images"

# Create resized_images directory if it doesn't exist
mkdir -p "$RESIZED_DIR"

# Collect all files to search: _config.yml + top-level markdown pages
readarray -t md_files < <(find "$REPO_DIR" -maxdepth 1 -name "*.md")
search_files=("$REPO_DIR/_config.yml" "${md_files[@]}")

# Extract image paths, excluding feature_image entries
image_paths=$(grep -ohP "(?<!feature_)image: \K[^\s]+" "${search_files[@]}" | sort -u)

for image_path in $image_paths; do
    # Remove leading slash if present
    image_path="${image_path#/}"

    # Get the full file path
    full_path="$REPO_DIR/$image_path"

    # Skip if file doesn't exist
    if [ ! -f "$full_path" ]; then
        echo "Warning: Image not found: $full_path"
        continue
    fi

    # Build output filename: basename_SIZExSIZE.webp (e.g. roses_480x480.webp)
    filename=$(basename -- "$full_path")
    filename_base="${filename%.*}"
    resized_filename="${filename_base}_${SIZE}.webp"
    resized_path="$RESIZED_DIR/$resized_filename"

    if [ ! -f "$resized_path" ]; then
        echo "Creating resized image: $resized_filename"

        convert "$full_path" \
            -auto-orient \
            -resize "$SIZE" \
            -quality 85 \
            "$resized_path"

        if [ $? -eq 0 ]; then
            echo "  ✓ $resized_path"
        else
            echo "  ✗ Failed for: $filename"
            continue
        fi
    else
        echo "Already exists: $resized_filename"
    fi

    # Update references in all search files, skipping feature_image lines
    resized_ref="/assets/images/resized_images/$resized_filename"
    for f in "${search_files[@]}"; do
        sed -i "/feature_image/!s|image: /$image_path|image: $resized_ref|g" "$f"
        sed -i "/feature_image/!s|image: $image_path|image: $resized_ref|g" "$f"
    done
done

echo ""
echo "Done! Resized images saved to: $RESIZED_DIR"
echo "Updated references in: _config.yml + ${#md_files[@]} markdown files"
