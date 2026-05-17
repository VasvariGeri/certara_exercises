# Exercise 3: Minikube REST Service

This exercise packages a simple Go REST service and deploys it to a local minikube cluster.

## Planned Scope

- Package the provided REST service with a `/hello-world` endpoint.
- Build a container image locally.
- Deploy the service to minikube with Kubernetes manifests.
- Expose the service through a localhost URI.
- Add automation for common local workflows.
- Check required tooling before running provisioning or deployment steps.
- Prefer the minikube local registry/image environment over a remote registry.

## Expected Response

```json
{
  "message": "Hello World"
}
```

## Layout

```text
.
├── Dockerfile
├── k8s/
├── rest_1.0/
└── scripts/
```

## Build Image

Build the container image locally:

```sh
docker build -t certara-rest:1.0 exercise_3
```

The Dockerfile uses the provided Linux binary matching the target image architecture.
It uses Alpine Linux as a small, common base image so the container remains easy to inspect and debug during local development.

## Kubernetes Manifests

The Kubernetes manifests live under `k8s/` and create:

- a dedicated namespace,
- a single-replica deployment,
- a ClusterIP service.

The deployment uses the local image tag `certara-rest:1.0` with `imagePullPolicy: IfNotPresent`, so minikube can use an image built locally instead of pulling from a remote registry.

## Deploy To Minikube

Deploy the service to a local minikube cluster:

```sh
exercise_3/scripts/deploy-minikube.sh
```

The script checks required tooling, starts or reuses the `certara-exercise-3` minikube profile, builds the image locally, loads it into minikube, applies the Kubernetes manifests, and waits for the deployment rollout.

You can override defaults when needed:

```sh
MINIKUBE_PROFILE=minikube IMAGE_NAME=certara-rest:1.0 exercise_3/scripts/deploy-minikube.sh
```

## Run Locally

Deploy the service and open a localhost port-forward with one command:

```sh
exercise_3/scripts/run-local.sh
```

Then call the endpoint from another terminal:

```sh
curl http://127.0.0.1:18080/hello-world
```

The command keeps the port-forward running until interrupted with `Ctrl+C`.

## Access From Localhost

Forward the Kubernetes service to localhost:

```sh
exercise_3/scripts/port-forward.sh
```

Then call the endpoint from another terminal:

```sh
curl http://127.0.0.1:18080/hello-world
```

Run an automated smoke test:

```sh
exercise_3/scripts/smoke-test.sh
```

The provided binary returns:

```json
{"message":"Hello World!"}
```

## Make Targets

The repository root Makefile wraps the common Exercise 3 commands:

```sh
make validate-exercise-3
make build-exercise-3
make deploy-exercise-3
make port-forward-exercise-3
make run-exercise-3
make smoke-test-exercise-3
```

The `run-exercise-3` and `port-forward-exercise-3` targets keep running until interrupted.

## Workflow

The local workflow is:

1. Start or reuse a minikube cluster.
2. Build the application image locally.
3. Apply the Kubernetes manifests.
4. Open a localhost endpoint and call `/hello-world`.

## Notes

The provided `rest_1.0` archive contains prebuilt binaries for multiple operating systems and CPU architectures. The container image uses the Linux binaries only.
