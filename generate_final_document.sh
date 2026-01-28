#!/bin/bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Setup output directory
mkdir -p "$SCRIPT_DIR/out"
rm -f "$SCRIPT_DIR/out/*.adoc"
rm -f "$SCRIPT_DIR/out/*.pdf"

# Start with the header
cat "$SCRIPT_DIR/docs/header.adoc" > "$SCRIPT_DIR/out/final-document.adoc"

# Process each section in order
for section in goals environment system project; do
    echo "Processing section: $section"

    # Add section header
    if [ -f "$SCRIPT_DIR/docs/$section/header.adoc" ]; then
        echo "" >> "$SCRIPT_DIR/out/final-document.adoc"
        cat "$SCRIPT_DIR/docs/$section/header.adoc" >> "$SCRIPT_DIR/out/final-document.adoc"
    fi
    
    # Add all other files in alphabetical order
    if [ -d "$SCRIPT_DIR/docs/$section" ]; then
        for file in $(ls "$SCRIPT_DIR/docs/$section/" | grep -E ".+\.adoc" | grep -v "header.adoc" | sort); do
            echo "Adding file: $file"
            echo "" >> "$SCRIPT_DIR/out/final-document.adoc"
            cat "$SCRIPT_DIR/docs/$section/$file" >> "$SCRIPT_DIR/out/final-document.adoc"
        done
    fi
done

# Generate PDF
asciidoctor-pdf "$SCRIPT_DIR/out/final-document.adoc" -o "$SCRIPT_DIR/out/final-document.pdf"

echo "Document generation complete. Output files:"
echo "- $SCRIPT_DIR/out/final-document.adoc"
echo "- $SCRIPT_DIR/out/final-document.pdf"
