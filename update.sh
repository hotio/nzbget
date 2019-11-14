#!/bin/bash

version=$(curl -fsSL "https://api.github.com/repos/nzbget/nzbget/releases" | jq -r .[0].name | sed s/v//g)
find . -type f -name '*.Dockerfile' -exec sed -i "s/ARG NZBGET_VERSION=.*$/ARG NZBGET_VERSION=${version}/g" {} \;
find . -type f -name '*.Dockerfile' -exec sed -i "s/ARG NZBGET_VERSION_SHORT=.*$/ARG NZBGET_VERSION_SHORT=${version//-testing/}/g" {} \;
sed -i "s/{TAG_VERSION=.*}$/{TAG_VERSION=${version//-testing/}}/g" .drone.yml
echo "##[set-output name=version;]${version//-testing/}"
