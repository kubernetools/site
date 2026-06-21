#!/bin/bash
set -e

DOCGEN="../../docgen/main/target/debug/docgen"

rm -rf ./site/docs/latest ./site/docs/v*
rm -f ./site/robots.txt ./site/sitemap.xml

"$DOCGEN" generate \
  --k8s-version v1.36 \
  --out ./site \
  --base-url https://www.kubernetools.com \
  --is-latest

for i in 1 2 3; do
  PREV="v1.$((36 - i))"
  echo "Generating $PREV..."
  "$DOCGEN" generate \
    --k8s-version "$PREV" \
    --out ./site \
    --base-url https://www.kubernetools.com
done
