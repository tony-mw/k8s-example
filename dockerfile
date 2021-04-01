FROM golang:1.14-alpine AS build

WORKDIR /src/
COPY app/homepage.html app/webserver.go app/go.* /src/
RUN CGO_ENABLED=0 go build -o /bin/goapp

FROM alpine:latest
COPY --from=build /bin/goapp /bin/goapp
RUN mkdir /views
COPY --from=build /src/homepage.html /views/homepage.html
ENTRYPOINT ["/bin/goapp"]
EXPOSE 8080