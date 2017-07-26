#!/bin/bash

echo "deploying to gh-pages"

set -o errexit

rm -rf site
mkdir site

echo "checkout gh-pages branch from playground-elm.git"
git clone https://ccamel:$GH_TOKEN@github.com/ccamel/playground-elm.git -b gh-pages --depth 1 site

cd site

git config user.email "$USER_EMAIL"
git config user.name "$USER_NAME"
git config push.default simple

# add changes
echo "copy dist"
cp -R ../dist/* .

# deploy
echo "deploy"
if [[ `git status --porcelain` ]]; then
  git add --all .
  git commit -m "update playground-elm site"

  echo "done"
  git push --quiet
else
  echo "no changes"
fi

echo "done"