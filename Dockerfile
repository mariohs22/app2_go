FROM golang:1.16-alpine as builder

WORKDIR /app
COPY . .
RUN go mod download
# Build the binary totally static
# Source: http://blog.wrouesnel.com/articles/Totally%20static%20Go%20builds/
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o compile .

FROM scratch
ENV GIN_MODE=release
# Copy user and group from builder container.
# COPY --from=builder /etc/passwd /etc/passwd
# COPY --from=builder /etc/group  /etc/group
# Copy the binary built.
COPY --from=builder /app/compile .
# Use non-privileged user in container.
# USER mario:mario
# EXPOSE 8080/tcp
EXPOSE 8080
ENTRYPOINT [ "/compile" ]