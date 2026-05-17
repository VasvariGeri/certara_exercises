#!/usr/bin/env sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
LOCAL_PORT="${LOCAL_PORT:-18080}"

"${SCRIPT_DIR}/deploy-minikube.sh"

echo
echo "REST service is available while this command is running:"
echo "  http://127.0.0.1:${LOCAL_PORT}/hello-world"
echo
echo "Press Ctrl+C to stop the localhost port-forward."

exec "${SCRIPT_DIR}/port-forward.sh"
