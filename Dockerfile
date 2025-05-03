# Stage 1: Build
FROM golang:1.19-alpine AS builder

# Install git (dibutuhkan saat go mod download)
RUN apk add --no-cache git

WORKDIR /app

# Copy dependency files dan download dependencies
COPY go.mod ./
COPY go.sum ./
RUN go mod download

# Copy seluruh source code
COPY . .

# Build binary
RUN go build -o server

# Stage 2: Runtime
FROM alpine:latest

WORKDIR /app

# Install SSL cert (jika backend butuh HTTPS/SSL request ke luar)
RUN apk add --no-cache ca-certificates

# Salin binary dari builder
COPY --from=builder /app/server .

EXPOSE 5000

CMD ["./server"]
