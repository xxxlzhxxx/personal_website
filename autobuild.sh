#!/bin/bash

# Set up directories
source_dir="src"
build_dir="build"
if [ ! -d "$build_dir" ]; then
  mkdir "$build_dir"
fi

# Convert Markdown files to HTML
for file in "$source_dir"/*.md; do
  if [ -f "$file" ]; then
    output_file="$build_dir"/"$(basename "${file%.md}").html"
    if pandoc -s "$file" -o "$output_file" 2>/dev/null; then
      echo "Converted $file to HTML"
    else
      echo "Error converting $file to HTML"
    fi
  fi
done

# Generate index file
index_file="$build_dir"/index.html
echo "<h1>Blog Posts</h1>" > "$index_file"
for file in "$build_dir"/*.html; do
  if [ "$file" != "$index_file" ]; then
    link="$(basename "${file%.html}")"
    echo "<p><a href=\"$link.html\">$link</a></p>" >> "$index_file"
  fi
done
echo "Generated index file"