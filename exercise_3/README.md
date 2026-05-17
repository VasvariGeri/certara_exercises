# Exercise 3: Minikube REST Service

This exercise packages a simple Go REST service and deploys it to a local minikube cluster.

## Planned Scope

- Provide a Go service with a `/hello-world` endpoint.
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

## Planned Layout

```text
.
├── app/
├── k8s/
└── scripts/
```

## Planned Workflow

The final workflow should let a developer run a small number of local commands to:

1. Start or reuse a minikube cluster.
2. Build the application image locally.
3. Apply the Kubernetes manifests.
4. Open a localhost endpoint and call `/hello-world`.

## Notes

The original exercise mentions a `rest_1.0.zip` application archive. If that archive is available, the application source can be placed under `app/`. If not, this repository will provide an equivalent minimal Go implementation matching the required endpoint contract.
