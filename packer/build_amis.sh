#!/bin/bash

VERSION=$1; shift
REGION="us-west-2"

AWS_PROFILE=lamp packer build \
 -var "region=$REGION" \
 -var "build_version=$VERSION" \
 lamp.json

