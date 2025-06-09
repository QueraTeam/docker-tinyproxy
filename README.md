# docker-tinyproxy

A minimal Docker image for [Tinyproxy](https://tinyproxy.github.io/), built on Alpine Linux. This image is suitable for lightweight HTTP/HTTPS proxy deployments in containerized environments.

## Features

- Based on `alpine:latest` for a small footprint
- Installs `tinyproxy` and `curl`
- Exposes port `8888` by default
- Automated multi-architecture builds (amd64, arm64) via GitHub Actions
- Images published to GitHub Container Registry (`ghcr.io/querateam/docker-tinyproxy:latest`)

## Usage

### Pull the image

```sh
docker pull ghcr.io/querateam/docker-tinyproxy:latest
```

### Run the container

```sh
docker run -d -p 8888:8888 ghcr.io/querateam/docker-tinyproxy:latest
```

### Customization
You can customize the Tinyproxy configuration by mounting a custom `tinyproxy.conf` file:

```sh
docker run -d -p 8888:8888 -v /path/to/your/tinyproxy.conf:/etc/tinyproxy/tinyproxy.conf ghcr.io/querateam/docker-tinyproxy:latest
```

You can also restrict proxy access to specific hosts by setting the `ALLOWED_HOSTS` environment variable (comma-separated list):

```sh
docker run -d -p 8888:8888 -e ALLOWED_HOSTS="example.com,another.com" ghcr.io/querateam/docker-tinyproxy:latest
```

### Running as a Non-Root User

For enhanced security, you can run the Tinyproxy container as a non-root user. Use the `--user` flag with `docker run` to specify a non-root UID and GID:

```sh
docker run -d -p 8888:8888 --user 1234:1234 ghcr.io/querateam/docker-tinyproxy:latest
```

