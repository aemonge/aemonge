#!/bin/bash

# Define the articles directory
ARTICLES_DIR="$HOME/articles"

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
    quarto render "$file" --to html -o "$file_name.html" --css '/articles.css' || exit 1

    # Replace the paths in the rendered HTML file
    sed -i "s|${file_name}_files|/articles|g" "$file_name.html"

    # Move the rendered file to the output directory
    mv "$file_name.html" "$output_dir/$file_name.html"
done

# --------------
# Generate the articles index page dynamically
ARTICLES_INDEX="docs/articles/index.html"

cat <<EOF >"$ARTICLES_INDEX"
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Articles | Andres Monge</title>
    <style>
      body {
        background: #b8ae9e;
        color: #3d2b59;
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
      }
      a {
        color: #3d2b59;
        text-decoration: none;
      }
      a:hover {
        color: #005e86;
        text-decoration: underline;
      }
      .nav-bar {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        padding: 10px 0px;
      }
      .nav-bar a {
        padding: 5px 10px;
        border-radius: 5px;
        background: #e0d6c6;
      }
      .nav-bar a:hover {
        background: #d0c6b6;
      }

      iframe#article-frame {
          width: calc(100vw - 6px);
          height: calc(100vh - 100px);
          border: 3px solid #005e86;
      }

      iframe#article-frame body h1 {
          color: blue;
      }
    </style>
  </head>
  <body>
    <div class="nav-bar">
EOF

# Group articles by category and generate the navigation bar
declare -A categories
first_article_loaded=false
first_article_url=""
for file in $(find "$ARTICLES_DIR" -name "*.qmd"); do
    # Skip empty .qmd files
    if [[ ! -s "$file" ]]; then
        continue
    fi

    category=$(basename "$(dirname "$file")")
    title=$(basename "$file" .qmd | tr '-' ' ' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')
    relative_path="${file#$ARTICLES_DIR/}"
    output_dir="/articles/$(dirname "$relative_path")"
    file_name=$(basename "$file" .qmd)
    article_url="$output_dir/$file_name.html"

    # Add the article to the navigation bar
    categories["$category"]+="<a href=\"$article_url\" target=\"article-frame\">$category | $title</a>"

    # Set the first article as the pre-loaded article
    if [[ "$first_article_loaded" == false ]]; then
        first_article_url="$article_url"
        first_article_loaded=true
    fi
done

# Add articles to the navigation bar
for category in "${!categories[@]}"; do
    echo "${categories[$category]}" >>"$ARTICLES_INDEX"
done

# Write the rest of the HTML with the pre-loaded article
# <iframe id="article-frame" src="$first_article_url" name="article-frame"></iframe>
cat <<EOF >>"$ARTICLES_INDEX"
    </div>
    <iframe id="article-frame" src="/articles/features/annotations_performance.html" name="article-frame"></iframe>
  </body>
</html>
EOF

echo "Build completed successfully!"
