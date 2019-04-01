FROM golang AS build-env
ADD . /go/src/app
WORKDIR /go/src/app
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o /go/src/app/goappk8s

FROM alpine:3.9
RUN apk add -U tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
COPY --from=build-env /go/src/app/goappk8s /usr/local/bin/goappk8s
EXPOSE 8080
CMD [ "/usr/local/bin/goappk8s" ]
