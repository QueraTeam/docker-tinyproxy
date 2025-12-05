FROM alpine:3.23
WORKDIR /app
RUN apk add --no-cache tinyproxy curl && mv /etc/tinyproxy/tinyproxy.conf /etc/tinyproxy/tinyproxy.default.conf
COPY entrypoint.sh /app/entrypoint.sh
ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]
