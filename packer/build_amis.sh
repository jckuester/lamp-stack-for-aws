#!/bin/bash

function main {
    if [ $# != 1 ]; then
        echo "Usage: $0 [build-version]"
        exit 1
    fi

    local version=$1; shift
    local region=$(aws --profile lamp configure get region || true)
    
    if [ -z "$region" ]; then
        echo "Error: region for profile 'lamp' not set"
        exit 1
    fi

    AWS_PROFILE=lamp packer build \
        -var "region=$region" \
        -var "build_version=$version" \
        lamp.json
}

main "$@"
