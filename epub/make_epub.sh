#!/bin/sh

OS=$(uname -s)
if [ "$OS" == "Darwin" ]; then
    PATH=/Applications/calibre.app/Contents/console.app/Contents/MacOS:$PATH
fi

# find required command line utilities
GROOVY_BIN=$(which groovy)
EBOOK_CONVERT_BIN=$(which ebook-convert)
MARKDOWN_BIN=$(which markdown)
if [ "$MARKDOWN_BIN" == "" ]; then
    MARKDOWN_BIN=$(which Markdown.pl)
fi

PREREQ_MISSING=0
if [ "$GROOVY_BIN" == "" ]; then
    echo "You must download and install Groovy and make sure it is in your PATH"
    PREREQ_MISSING=1
fi
if [ "$EBOOK_CONVERT_BIN" == "" ]; then
    echo "You must download and install Calibre and make sure it is in your PATH"
    PREREQ_MISSING=1
fi
if [ "$MARKDOWN_BIN" == "" ]; then
    echo "You must download and install Markdown and make sure it is in your PATH"
    PREREQ_MISSING=1
fi

if [ "$PREREQ_MISSING" != "0" ]; then
    echo "See the appropriate README files in the epub folder"
    echo "for installation isntructions"
    exit 1
fi 


SCRIPT_DIR=$(dirname "$0")
PATH=$PATH:$GROOVY_BIN_DIR

export EBOOK_CONVERT_BIN MARKDOWN_BIN PATH

chmod +x make_epub.groovy
$SCRIPT_DIR/make_epub.groovy $1
