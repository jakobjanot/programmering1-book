set positional-arguments

out_dir := "build"

default:
    @just --list

# Compile the PDF version of the book
pdf out=out_dir:
    mkdir -p {{out}}
    typst compile --font-path ./fonts main.typ {{out}}/programmering1-java.pdf

# Compile the HTML (website) version of the book
html out=out_dir:
    mkdir -p {{out}}
    typst compile --features html --format html main-html.typ {{out}}/index.html
    cp style.css {{out}}/style.css

# Compile both the PDF and the HTML version
all out=out_dir:
    just pdf {{out}}
    just html {{out}}
