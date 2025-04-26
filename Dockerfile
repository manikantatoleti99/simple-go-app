# Step 1: Build Stage
FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY main.go .

RUN go build -o server .

# Step 2: Run Stage
FROM alpine:latest

RUN adduser -D myuser

COPY --from=builder /app/server /server

USER myuser

EXPOSE 8080

ENTRYPOINT ["/server"]
