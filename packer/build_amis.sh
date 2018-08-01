#!/bin/bash

function main {
    if [ $# != 2 ]; then
        echo "Usage: $0 [profile] [build-version]"
        exit 1
    fi

    local profile=$1; shift
    local version=$1; shift
    local region=$(aws --profile $profile configure get region || true)

    if [ -z "$region" ]; then
        echo "Error: region for profile $profile not set"
        exit 1
    fi

    AWS_PROFILE="$profile" packer build \
        -var "region=$region" \
        -var "build_version=$version" \
        lamp.json
}

main "$@"
