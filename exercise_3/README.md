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

## Planned Workflow

The final workflow should let a developer run a small number of local commands to:

1. Start or reuse a minikube cluster.
2. Build the application image locally.
3. Apply the Kubernetes manifests.
4. Open a localhost endpoint and call `/hello-world`.

## Notes

The provided `rest_1.0` archive contains prebuilt binaries for multiple operating systems and CPU architectures. The container image uses the Linux binaries only.
