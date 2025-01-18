#!/bin/bash

# echo "Checking for pamac dependencies..."
# pamac build gomplate-bin
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

# --------------
# Functions

# Clean up non-.qmd files in the articles directory
clean_up() {
    echo "Cleaning up non-.qmd files in $ARTICLES_DIR..."
    find "$ARTICLES_DIR" -type f ! -name "*.qmd" -exec rm -f {} \; >/dev/null 2>&1
    find "$ARTICLES_DIR" -type d -name "*_files" -exec rm -Rf {} \; >/dev/null 2>&1
    echo "Clean-up completed!"
}

# Build the resume PDF
build_resume() {
    echo "Building resume..."
    mv docs/avatar.png .
    pdflatex resume.tex
    rm resume.aux resume.log resume.out
    mv resume.pdf docs/python-tech-lead_andres-monge.pdf
    mv avatar.png docs/.
    echo "Resume build completed!"
}

# Render articles with Quarto
render_articles() {
    echo "Rendering articles..."
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

        # Remove the minified CSS links
        sed -i -E 's/(-[a-f0-9]{32})(\.css|\.min\.css)/\2/g' "$file_name.html"

        # Move the rendered file to the output directory
        mv "$file_name.html" "$output_dir/$file_name.html"
    done
    echo "Article rendering completed!"
}

# Generate article name from file path
generate_article_name() {
    local file_path="$1"
    local base_name=$(basename "$file_path" .html)
    echo "$base_name" | tr '_' ' ' | sed -e 's/\b\(.\)/\u\1/g'
}

# Generate the navigation data for Gomplate
generate_navigation_data() {
    local RENDERED_FILES=$(find "$ARTICLES_DIR" -name "*.qmd" -o -name "*.quarto_ipynb")
    if [[ -z "$RENDERED_FILES" ]]; then
        echo "Warning: No articles were found. Skipping index generation."
        exit 0
    fi

    # Initialize the JSON structure as an empty array
    local NAVIGATION_JSON='[]'

    for file in $RENDERED_FILES; do
        relative_path="${file#$ARTICLES_DIR/}"
        IFS='/' read -ra path_parts <<<"$relative_path"

        language="${path_parts[0]}"
        category="${path_parts[1]}"
        article_name=$(basename "${file%.*}")
        article_url="/articles/${relative_path%.*}.html"

        # Check if the language already exists in the JSON
        if echo "$NAVIGATION_JSON" | jq -e --arg lang "$language" 'any(.[]; .language == $lang)' >/dev/null; then
            # Language exists, add the article to its articles array
            NAVIGATION_JSON=$(echo "$NAVIGATION_JSON" | jq --arg lang "$language" --arg cat "$category" \
                --arg name "$article_name" --arg url "$article_url" \
                'map(
                    if .language == $lang then
                        .articles += [{"category": $cat, "url": $url, "name": $name}]
                    else
                        .
                    end
                )')
        else
            # Language does not exist, add it with the new article
            NAVIGATION_JSON=$(
                echo "$NAVIGATION_JSON" | jq --arg lang "$language" --arg cat "$category" \
                    --arg name "$article_name" --arg url "$article_url" \
                    '. += [{"language": $lang, "articles": [{"category": $cat, "url": $url, "name": $name}]}]'
            )
        fi
    done

    echo "$NAVIGATION_JSON" | jq '.'
}

# Generate the articles index page using Gomplate
generate_index() {
    echo "Generating articles index page..."
    local ARTICLES_INDEX="docs/articles/index.html"

    # Check if the template file exists
    if [[ ! -f "./docs/articles_template.html.tmpl" ]]; then
        echo "Error: Template file './docs/articles_template.html.tmpl' not found." | tee -a "$FAILED_ARTICLES_LOG"
        exit 1
    fi

    # Generate navigation data and validate it with jq
    echo "Generating and validating navigation data..."
    local NAVIGATION_DATA
    NAVIGATION_DATA=$(generate_navigation_data)

    # Validate the JSON structure with jq
    if ! echo "$NAVIGATION_DATA" | jq . >/dev/null 2>&1; then
        echo "Error: Invalid JSON structure in navigation data. Check $FAILED_ARTICLES_LOG for details." | tee -a "$FAIL
ED_ARTICLES_LOG"
        echo "$NAVIGATION_DATA" >>"$FAILED_ARTICLES_LOG"
        exit 1
    fi

    # Save the navigation data to a JSON file for debugging
    echo "$NAVIGATION_DATA" | jq '
      map({
        language,
        articles: (.articles | group_by(.category) | map({
          category: .[0].category,
          articles: (. | unique_by(.url) | map(
            if .url | endswith("/.html") then empty
            else . + {name: (.name | gsub("_"; " "))}
            end
          ))
        }))
      })
    ' >./docs/articles_navigation.json
    echo "Navigation data saved to ./docs/articles_navigation.json"

    # Render the index page using Gomplate
    echo "Rendering index page with Gomplate..."
    if ! gomplate \
        -d nav=./docs/articles_navigation.json \
        -f ./docs/articles_template.html.tmpl \
        -o "$ARTICLES_INDEX"; then
        echo "Error: Failed to render index page. Check $FAILED_ARTICLES_LOG for details." | tee -a "$FAILED_ARTICLES_LO
G"
        exit 1
    fi

    echo "Index generation completed! in $ARTICLES_INDEX"
}

# Check for failed articles
check_failed_articles() {
    if [[ -s "$FAILED_ARTICLES_LOG" ]]; then
        echo "Build completed with errors. Check $FAILED_ARTICLES_LOG for details."
    else
        echo "Build completed successfully!"
    fi
}

# --------------
# Main script execution

# Clear the log file
# >"$FAILED_ARTICLES_LOG"

# Clean up non-.qmd files
clean_up

# Build the resume
build_resume

# Render articles
render_articles

# Generate the articles index page
generate_index

# Check for failed articles
check_failed_articles
clean_up
