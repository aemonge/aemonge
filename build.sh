#!/bin/bash

# echo "Checking for pamac dependencies..."
# pamac install python-numpy
# pamac install texlive-fontsextra texlive-fontsrecommended
# pamac install texlive-latexextra
# pamac install texlive-fontsextra
# pamac install python-pydantic
# pamac install python-nbformat
# pamac install python-jupyter-client python-jupyter-ydoc
# pamac install jupyter
# pamac install quarto-cli-bin
# pamac install python-jupyter
# pamac install python-jupyter-core
# pamac install jupyter-nbformat
# pamac install jupyter-console jupyter
# pamac install jupyter-console jupyter-lsp
# pamac install texlive-fontsextra texlive-fontutils
# pamac install texlive-plaingeneric

# Define the articles directory
ARTICLES_DIR="$HOME/articles"

# Log file for failed articles
FAILED_ARTICLES_LOG="failed_articles.log"
>"$FAILED_ARTICLES_LOG" # Clear the log file

# --------------
# Build the resume PDF
mv docs/avatar.png .
pdflatex resume.tex

# Clean up LaTeX artifacts
rm resume.aux
rm resume.log
rm resume.out

# Move the resume and avatar back to the docs directory
mv resume.pdf docs/python-tech-lead_andres-monge.pdf
mv avatar.png docs/.

# --------------
# Render articles with Quarto
mkdir -p docs/articles
find "$ARTICLES_DIR" -name "*.qmd" | while read -r file; do
    error=false

    # Skip empty .qmd files
    if [[ ! -s "$file" ]]; then
        echo "Skipping empty file: $file"
        continue
    fi

    relative_path="${file#$ARTICLES_DIR/}"
    output_dir="docs/articles/$(dirname "$relative_path")"
    file_name=$(basename "$file" .qmd)
    mkdir -p "$output_dir"

    # Render the article
    echo "Rendering $file..."
    quarto render "$file" --to html -o "$file_name.html" --css '/articles.css' || {
        echo "Failed to render: $file" >>"$FAILED_ARTICLES_LOG"
        error=true
    }

    # Skip further processing if rendering failed
    if $error; then
        continue
    fi

    # Replace the paths in the rendered HTML file
    sed -i "s|${file_name}_files|/articles|g" "$file_name.html"

    # Move the rendered file to the output directory
    mv "$file_name.html" "$output_dir/$file_name.html"
done

# --------------
# Generate the articles index page dynamically
ARTICLES_INDEX="docs/articles/index.html"

# Load the template
if [[ ! -f "./docs/articles_template.html" ]]; then
    echo "Error: Template file './docs/articles_template.html' not found."
    exit 1
fi
TEMPLATE=$(cat ./docs/articles_template.html)

# Group articles by category and generate the navigation bar
NAVIGATION=""
first_article_loaded=false
first_article_url=""

# Find all rendered HTML files
RENDERED_FILES=$(find "docs/articles" -name "*.html" | grep -v "index.html")
if [[ -z "$RENDERED_FILES" ]]; then
    echo "Warning: No articles were rendered. Skipping index generation."
    exit 0
fi

# Function to generate article name from file path
generate_article_name() {
    local file_path="$1"
    # Extract the base name (e.g., "generic_http_responses.html")
    local base_name=$(basename "$file_path" .html)
    # Replace underscores with spaces and capitalize words
    echo "$base_name" | tr '_' ' ' | sed -e 's/\b\(.\)/\u\1/g'
}

# Process each rendered article
declare -A categories
for file in $RENDERED_FILES; do
    # Extract the relative path and category
    relative_path="${file#docs/articles/}"
    category=$(dirname "$relative_path")
    article_name=$(generate_article_name "$file")
    article_url="/articles/$relative_path"

    # Add the article to its category
    if [[ -z "${categories[$category]}" ]]; then
        categories[$category]=""
    fi
    categories[$category]+="<a href=\"$article_url\" target=\"article-frame\">$article_name</a>"

    # Set the first article as the pre-loaded article
    if [[ "$first_article_loaded" == false ]]; then
        first_article_url="$article_url"
        first_article_loaded=true
    fi
done

# Generate the navigation bar with categories
for category in "${!categories[@]}"; do
    NAVIGATION+="<div class=\"subcategory\" onclick=\"toggleCategory(this)\">$category</div>"
    NAVIGATION+="<div class=\"articles\">${categories[$category]}</div>"
done

# Debugging: Print the generated NAVIGATION
echo "Generated NAVIGATION: $NAVIGATION"

# Replace placeholders in the template
TEMPLATE=${TEMPLATE//'{{NAVIGATION}}'/"$NAVIGATION"}
TEMPLATE=${TEMPLATE//'{{FIRST_ARTICLE_URL}}'/"$first_article_url"}

# Write the final HTML to the articles index page
echo "$TEMPLATE" >"$ARTICLES_INDEX"

# Check if any articles failed to render
if [[ -s "$FAILED_ARTICLES_LOG" ]]; then
    echo "Build completed with errors. Check $FAILED_ARTICLES_LOG for details."
else
    echo "Build completed successfully!"
fi
