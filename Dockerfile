FROM golang:1.22 AS base
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o sudhakar


# Final stage with distroless image
FROM gcr.io/distroless/base
COPY --from=base /app/sudhakar .
COPY --from=base /app/static ./static
EXPOSE 8080
CMD [ "./sudhakar" ]
