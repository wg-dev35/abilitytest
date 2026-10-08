#!/bin/bash
#stages and commits current folder for changes after major updates
# - requires manual invocation
read -p "Commit description: " desc

git add . && \
git add -u && \
git commit -m "$desc" && \
git push