#!/bin/bash

arr( "design" "feature");

for ITEM in ${arr[@]}
    do
      git checkout $ITEM
      git checkout main build/css/bootstrap.min.css
      git checkout main build/css/bootstrap.min.css.map
      git checkout main build/js/lib/bootstrap.min.js
      git checkout main build/js/lib/bootstrap.min.js.map
      git add -A
      git commit -m "Updated new version of bootstrap"
    done
git checkout main
echo "updated changes"
