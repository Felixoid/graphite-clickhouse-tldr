FROM golang:alpine AS builder

RUN CGO_ENABLED=0 go install -ldflags '-extldflags "-static"' github.com/Felixoid/coal-mine@v0.4.0

FROM scratch

FROM alpine:latest

COPY --from=builder /go/bin/coal-mine /usr/bin/coal-mine

ENTRYPOINT ["/usr/bin/coal-mine"]
