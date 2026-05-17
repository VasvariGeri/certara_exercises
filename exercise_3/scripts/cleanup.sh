#!/usr/bin/env sh
set -eu

MINIKUBE_PROFILE="${MINIKUBE_PROFILE:-certara-exercise-3}"
NAMESPACE="${NAMESPACE:-certara-exercise-3}"
STOP_MINIKUBE="${STOP_MINIKUBE:-false}"

if ! command -v kubectl >/dev/null 2>&1; then
  echo "Missing required tool: kubectl" >&2
  exit 1
fi

kubectl --context "$MINIKUBE_PROFILE" delete namespace "$NAMESPACE" --ignore-not-found=true

if [ "$STOP_MINIKUBE" = "true" ]; then
  if ! command -v minikube >/dev/null 2>&1; then
    echo "Missing required tool: minikube" >&2
    exit 1
  fi

  minikube stop -p "$MINIKUBE_PROFILE"
fi
