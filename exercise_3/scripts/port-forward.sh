#!/usr/bin/env sh
set -eu

MINIKUBE_PROFILE="${MINIKUBE_PROFILE:-certara-exercise-3}"
NAMESPACE="${NAMESPACE:-certara-exercise-3}"
LOCAL_PORT="${LOCAL_PORT:-18080}"
SERVICE_PORT="${SERVICE_PORT:-80}"

kubectl --context "$MINIKUBE_PROFILE" -n "$NAMESPACE" port-forward "svc/rest-service" "${LOCAL_PORT}:${SERVICE_PORT}"
