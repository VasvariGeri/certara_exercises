# syntax=docker/dockerfile:1

FROM alpine:3.20

ARG TARGETARCH

COPY rest_1.0/rest_1.0_linux_${TARGETARCH} /usr/local/bin/rest-service

RUN adduser -D -H -u 10001 appuser

USER appuser
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/rest-service"]
