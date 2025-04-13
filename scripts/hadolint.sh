#!/bin/bash
docker run --rm \
  -v "$(pwd):/workdir" \
  -w "/workdir" \
  hadolint/hadolint \
  hadolint "$@" --config /workdir/.hadolint.json || true
