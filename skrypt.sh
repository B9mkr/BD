#!/bin/bash

# echo $2;
git add -A;

git status;

git commit -m \"$1\";

# git push
# pandoc $1.md --output=$1.pdf
