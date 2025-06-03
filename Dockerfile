FROM alpine:latest
WORKDIR /app
RUN apk add --no-cache tinyproxy curl
COPY run.sh /app/run.sh
EXPOSE 8888
ENTRYPOINT ["/bin/sh", "/app/run.sh"]
