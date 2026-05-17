#!/usr/bin/env sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
EXERCISE_DIR=$(CDPATH= cd -- "${SCRIPT_DIR}/.." && pwd)

IMAGE_NAME="${IMAGE_NAME:-certara-rest:1.0}"
MINIKUBE_PROFILE="${MINIKUBE_PROFILE:-certara-exercise-3}"
NAMESPACE="${NAMESPACE:-certara-exercise-3}"

"${SCRIPT_DIR}/check-tools.sh"

if ! minikube status -p "$MINIKUBE_PROFILE" >/dev/null 2>&1; then
  minikube start -p "$MINIKUBE_PROFILE"
fi

docker build -t "$IMAGE_NAME" "$EXERCISE_DIR"
minikube -p "$MINIKUBE_PROFILE" image load "$IMAGE_NAME"

kubectl --context "$MINIKUBE_PROFILE" apply -f "${EXERCISE_DIR}/k8s/namespace.yaml"
kubectl --context "$MINIKUBE_PROFILE" wait --for=jsonpath='{.status.phase}'=Active "namespace/${NAMESPACE}" --timeout=60s
kubectl --context "$MINIKUBE_PROFILE" apply -f "${EXERCISE_DIR}/k8s/service.yaml"
kubectl --context "$MINIKUBE_PROFILE" apply -f "${EXERCISE_DIR}/k8s/deployment.yaml"
kubectl --context "$MINIKUBE_PROFILE" -n "$NAMESPACE" rollout status deployment/rest-service --timeout=120s

echo "REST service deployed to minikube profile '${MINIKUBE_PROFILE}'."
