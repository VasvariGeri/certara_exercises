#!/usr/bin/env sh
set -eu

MINIKUBE_PROFILE="${MINIKUBE_PROFILE:-certara-exercise-3}"
NAMESPACE="${NAMESPACE:-certara-exercise-3}"
LOCAL_PORT="${LOCAL_PORT:-18080}"
SERVICE_PORT="${SERVICE_PORT:-80}"
URL="http://127.0.0.1:${LOCAL_PORT}/hello-world"
EXPECTED='{"message":"Hello World!"}'

kubectl --context "$MINIKUBE_PROFILE" -n "$NAMESPACE" rollout status deployment/rest-service --timeout=120s

kubectl --context "$MINIKUBE_PROFILE" -n "$NAMESPACE" port-forward "svc/rest-service" "${LOCAL_PORT}:${SERVICE_PORT}" >/tmp/certara-rest-port-forward.log 2>&1 &
PORT_FORWARD_PID=$!

cleanup() {
  kill "$PORT_FORWARD_PID" >/dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM

sleep 2

response=$(curl -fsS "$URL")

if [ "$response" != "$EXPECTED" ]; then
  echo "Unexpected response from ${URL}" >&2
  echo "Expected: ${EXPECTED}" >&2
  echo "Actual:   ${response}" >&2
  exit 1
fi

echo "Smoke test passed: ${response}"
