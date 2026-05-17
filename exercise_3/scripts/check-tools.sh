#!/usr/bin/env sh
set -eu

missing_tools=""

for tool in docker kubectl minikube; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    missing_tools="${missing_tools} ${tool}"
  fi
done

if [ -n "$missing_tools" ]; then
  echo "Missing required tools:${missing_tools}" >&2
  exit 1
fi

if ! docker info >/dev/null 2>&1; then
  echo "Docker is installed, but the Docker daemon is not reachable." >&2
  exit 1
fi

echo "All required tools are available."
