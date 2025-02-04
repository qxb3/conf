#!/bin/bash

# Check if a path argument is provided, default to current directory if not
if [ -z "$1" ]; then
  dir="."
else
  dir="$1"
fi

if [ -d "$dir/previews" ]; then
  rm -rf "$dir/previews"
  echo "> Deleted existing 'previews' directory."
fi

mkdir "$dir/previews"
echo "> Created a new 'previews' directory."

for image in "$dir"/*.png; do
  if [ -f "$image" ]; then
    magick "$image" -resize 25% "$dir/previews/$(basename "$image")"
    echo "> Optimized: $(basename "$image")"
  fi
done

echo "Preview generation complete!"
