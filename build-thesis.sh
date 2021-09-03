#!/bin/sh
# Copyright (C) 2014-2020 by Thomas Auzinger <thomas@auzinger.name>

usage() {
    echo "Usage: $0 path/to/THESIS.tex" >&2
}

# parse command line argument for the "SOURCE" variable value
SOURCE=
WORKDIR=
while [ $# -ge 1 ];
do
    arg="$1"
    case "$arg" in
        -h|--help)
            usage
            exit 1
            ;;
        *)
            # the value of SOURCE is the given file name without the '.tex'
            # extension.
            # the value of WORKDIR is the directory where the filename
            # resides.
            SOURCE="$(basename "$arg" .tex)"
            WORKDIR="$(dirname "$arg")"
            ;;
    esac
    shift
done

[ -n "$SOURCE" ] || {
    usage
    exit 1
}

cd "$WORKDIR"

echo "building thesis '$SOURCE' in directory '$WORKDIR'" >&2

# Build the thesis document
pdflatex "$SOURCE"
bibtex   "$SOURCE"
pdflatex "$SOURCE"
pdflatex "$SOURCE"
makeindex -t "$SOURCE.glg" -s "$SOURCE.ist" -o "$SOURCE.gls" "$SOURCE.glo"
makeindex -t "$SOURCE.alg" -s "$SOURCE.ist" -o "$SOURCE.acr" "$SOURCE.acn"
makeindex -t "$SOURCE.ilg" -o "$SOURCE.ind" "$SOURCE.idx"
pdflatex "$SOURCE"
pdflatex "$SOURCE"

echo
echo
echo Thesis document compiled.
