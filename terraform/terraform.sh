#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

function main {
    if [ $# -lt 2 ]; then
        echo "Usage: $0 <aws-profile> <terraform command>"
        exit 1
    fi

    local profile=$1; shift
    local cmd=$1; shift
    local region=$(aws --profile "$profile" configure get region || true)

    if [ -z "$region" ]; then
        echo "REGION not set"
        exit 1
    fi

    TF_VAR_PROFILE="$profile" TF_VAR_REGION="$region" terraform "$cmd"
}

main "$@"
