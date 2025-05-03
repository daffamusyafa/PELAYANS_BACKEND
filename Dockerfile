# Gunakan image golang resmi sebagai base image
FROM golang:1.18-alpine

# Set working directory di dalam container
WORKDIR /app

# Copy go mod dan go sum
COPY go.mod go.sum ./

# Install dependencies Go
RUN go mod tidy

# Copy seluruh kode ke dalam container
COPY . .

# Build aplikasi Go
RUN go build -o main .

# Tentukan port aplikasi
EXPOSE 5000

# Jalankan aplikasi
CMD ["./main"]
