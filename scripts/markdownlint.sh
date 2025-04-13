#!/bin/bash
docker run --rm \
  -v "$(pwd):/workdir" \
  -w "/workdir" \
  ghcr.io/igorshubovych/markdownlint-cli:latest \
  markdownlint "$@" --fix --config /workdir/.markdownlint.json || true
