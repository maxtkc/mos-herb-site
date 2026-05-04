#!/bin/bash
# Generate resized images for gallery items and update references in _config.yml

SIZE="480x480"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
REPO_DIR=$( dirname "$SCRIPT_DIR" )
IMG_DIR="$REPO_DIR/assets/images"
RESIZED_DIR="$IMG_DIR/resized_images"
CONFIG_FILE="$REPO_DIR/_config.yml"

# Create resized_images directory if it doesn't exist
mkdir -p "$RESIZED_DIR"

# Extract image paths from gallery_items in _config.yml
image_paths=$(grep -oP "image: \K[^\s]+" "$CONFIG_FILE" | sort -u)

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

    # Update the reference in _config.yml
    resized_ref="/assets/images/resized_images/$resized_filename"
    sed -i "s|image: /$image_path|image: $resized_ref|g" "$CONFIG_FILE"
    sed -i "s|image: $image_path|image: $resized_ref|g" "$CONFIG_FILE"
done

echo ""
echo "Done! Resized images saved to: $RESIZED_DIR"
echo "Updated references in: $CONFIG_FILE"
