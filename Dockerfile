FROM golang:1.16-alpine as builder

WORKDIR /build
COPY . .
RUN go mod download
# Build the binary totally static
# Source: http://blog.wrouesnel.com/articles/Totally%20static%20Go%20builds/
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o compile .

FROM scratch
ENV GIN_MODE=release
COPY --from=builder /build/compile /build/index.html ./
EXPOSE 8080
ENTRYPOINT [ "/compile" ]
