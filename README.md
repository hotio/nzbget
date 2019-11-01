# nzbget

[![GitHub](https://img.shields.io/badge/source-github-lightgrey?style=flat-square)](https://github.com/hotio/docker-nzbget)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/nzbget?style=flat-square)](https://hub.docker.com/r/hotio/nzbget)
[![Drone (cloud)](https://img.shields.io/drone/build/hotio/docker-nzbget?style=flat-square)](https://cloud.drone.io/hotio/docker-nzbget)

## Starting the container

Just the basics to get the container running:

```shell
docker run --rm --name nzbget -p 6789:6789 -v /tmp/nzbget:/config -e TZ=Etc/UTC hotio/nzbget
```

The environment variables below are all optional, the values you see are the defaults.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=022
-e VERSION=image
```

Possible values for `VERSION`:

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/nzbget/nzbget/releases/download/v20.0/nzbget-20.0-bin-linux.run
VERSION=file:///config/nzbget-20.0-bin-linux.run
```

## Executing your own scripts

If you have a need to do additional stuff when the container starts or stops, you can mount your script with `-v /docker/host/my-script.sh:/etc/cont-init.d/99-my-script` to execute your script on container start or `-v /docker/host/my-script.sh:/etc/cont-finish.d/99-my-script` to execute it when the container stops. An example script can be seen below.

```shell
#!/usr/bin/with-contenv bash

echo "Hello, this is me, your script."
```
