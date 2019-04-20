# [NZBGet](https://github.com/nzbget/nzbget)

[![badge](https://images.microbadger.com/badges/image/hotio/nzbget.svg)](https://microbadger.com/images/hotio/nzbget "Get your own image badge on microbadger.com")
[![badge](https://images.microbadger.com/badges/version/hotio/nzbget.svg)](https://microbadger.com/images/hotio/nzbget "Get your own version badge on microbadger.com")
[![badge](https://images.microbadger.com/badges/commit/hotio/nzbget.svg)](https://microbadger.com/images/hotio/nzbget "Get your own commit badge on microbadger.com")

## Donations

NANO: `xrb_1bxqm6nsm55s64rgf8f5k9m795hda535to6y15ik496goatakpupjfqzokfc`  
BTC: `39W6dcaG3uuF5mZTRL4h6Ghem74kUBHrmz`  
LTC: `MMUFcGLiK6DnnHGFnN2MJLyTfANXw57bDY`

## Starting the container

Just the basics to get the container running:

```shell
docker run --rm --name nzbget -p 6789:6789 -v /tmp/nzbget:/config hotio/nzbget
```

```yaml
nzbget:
  container_name: nzbget
  image: hotio/nzbget
  ports:
    - "6789:6789"
  volumes:
    - /tmp/nzbget:/config
```

The environment variables `PUID`, `PGID`, `UMASK`, `VERSION`, `BACKUP` and `TZ` are all optional, the values you see below are the default values, `TZ` isn't set by default.

By default the image comes with a stable version. You can however install a different version with the environment variable `VERSION`. The value `image` does nothing, but keep the included version, all the others install a different version when starting the container.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=022
-e VERSION=image
-e BACKUP=yes
-e TZ=Europe/Brussels
```

```yaml
environment:
  - PUID=1000
  - PGID=1000
  - UMASK=022
  - VERSION=image
  - BACKUP=yes
  - TZ=Europe/Brussels
```

Possible values for `VERSION`:

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/nzbget/nzbget/releases/download/v20.0/nzbget-20.0-bin-linux.run
VERSION=file:///config/nzbget-20.0-bin-linux.run
```

## Backing up the configuration

By default on every docker container shutdown a backup is created from the configuration files. You can change this behaviour.

```shell
-e BACKUP=no
```

```yaml
environment:
  - BACKUP=no
```

## Using a rclone mount

Mounting a remote filesystem using `rclone` can be done with the environment variable `RCLONE`. Use `docker exec -it --user hotio CONTAINERNAME rclone config` to configure your remote when the container is running. Configuration files for `rclone` are stored in `/config/.config/rclone`.

```shell
-e RCLONE="remote1:path/to/files,/localmount1|remote2:path/to/files,/localmount2"
```

```yaml
environment:
  - RCLONE=remote1:path/to/files,/localmount1|remote2:path/to/files,/localmount2
```

## Using a rar2fs mount

Mounting a filesystem using `rar2fs` can be done with the environment variable `RAR2FS`. The new mount will be read-only. Using a `rar2fs` mount makes the use of an unrar script obsolete. You can mount a `rar2fs` mount on top of an `rclone` mount, `rclone` mounts are mounted first.

```shell
-e RAR2FS="/folder1-rar,/folder1-unrar|/folder2-rar,/folder2-unrar"
```

```yaml
environment:
  - RAR2FS=/folder1-rar,/folder1-unrar|/folder2-rar,/folder2-unrar
```

## Extra docker priviliges

In most cases you will need some or all of the following flags added to your command to get the required docker privileges when using a rclone or rar2fs mount.

```shell
--security-opt apparmor:unconfined --cap-add SYS_ADMIN --device /dev/fuse
```

```yaml
security_opt:
  - apparmor:unconfined
cap_add:
  - SYS_ADMIN
devices:
  - /dev/fuse
```
