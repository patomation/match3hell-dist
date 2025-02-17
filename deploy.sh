#!/bin/bash
# Source: https://bitbrain.github.io/2019/02/18/automatically-publish-games-to-itchio.html
set -e
set -o pipefail

if [[ -z "${BUTLER_API_KEY}" ]]; then
  echo "Unable to deploy! No BUTLER_API_KEY environment variable specified!"
  exit 1
fi

prepare_butler() {
    echo "Preparing butler..."
    download_if_not_exist http://dl.itch.ovh/butler/linux-amd64/head/butler butler
    chmod +x butler
}

prepare_and_push() {
    echo "Push $3 build to itch.io..."
    ./butler push $2 $1:$3
}

download_if_not_exist() {
    if [ ! -f $2 ]; then
        curl -L -O $1 > $2
    fi
}


project="advolkit/match3hell"
artifact="."
platform="html"

prepare_butler

prepare_and_push $project $artifact $platform

echo "Done."
exit 0