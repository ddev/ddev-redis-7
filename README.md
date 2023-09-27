<div align="center">

# ddev-redis-7 - Redis 7 container for DDEV

[![GitHub release (with filter)](https://img.shields.io/github/v/release/ddev/ddev-redis-7)](https://github.com/ddev/ddev-redis-7/releases)
[![Tests](https://github.com/ddev/ddev-redis-7/actions/workflows/cron_tests.yml/badge.svg)](https://github.com/ddev/ddev-redis-7/actions/workflows/cron_tests.yml)
![project is maintained](https://img.shields.io/maintenance/yes/2024.svg)

</div>

This repository provides [Redis 7](https://redis.com) container for [DDEV](https://ddev.readthedocs.io/).

It is based on [redis:7-alpine](https://hub.docker.com/_/redis/tags?page=1&name=7) docker image and [DDEV custom compose files](https://ddev.readthedocs.io/en/stable/users/extend/custom-compose-files/)

## Comparison to **v6** (`ddev/ddev-redis`)

There are a lot of differences between [v6](https://github.com/ddev/ddev-redis) addon and this one

| Feature           | ddev/ddev-redis  | ddev/ddev-redis-7 |
| ----------------- | ---------------- | ----------------- |
| Maximum Memory    | Unlimited        | 512Mb             |
| Persistence       | No               | **Yes**           |
| Redis Version     | 6.2.5            | 7.2.1             |
| Image Size        | ~40Mb            | ~11Mb             |
| Anonymous Volumes | On every restart | **NO**            |
| Optimized config  | No               | **Yes**           |

### Anonymous volumes - Wait, what?

Official redis docker container mounts an anonymous volume on `/data` because... reasons. That volume is recreated on every restart. This one mounts the persistence directory on `/data` and names it according to the project name, and gives it a proper label. This way, each DDEV project has it's own data volume, and data can persist accordingly

### Persistence?

Yes, persistence. This container is configured to persist data on `/data` volume. This means that if you stop the container, and start it again, the data will be there. This is useful for long-term caching of data, and for keeping the cache primed between ddev restarts.

## Installation

```
$ ddev get ddev/ddev-redis-7
$ ddev restart
```

> [!IMPORTANT]  
> Authentication is setup by default, and the password is `redis`.  
> If needed, you can auth with a username and password.  
> Username is `redis` as well.

## Configuration

Redis configuration files are split in the `.ddev/redis/conf` folder, you can modify them as you wish.  
Otherwise, plugin just works out of the box.

## Commands

Addon exposes the following commands

| Command           | Usage              | Description                        |
| ----------------- | ------------------ | ---------------------------------- |
| `redis`           | `ddev redis`       | Launches the **redis-cli**         |
| `redis *COMMAND*` | `ddev redis`       | Run an arbitrary redis-cli command |
| `redis-flush`     | `ddev redis-flush` | Clears all the Redis Databases     |
___

**Based on the original [ddev-contrib recipe](https://github.com/ddev/ddev-contrib/tree/master/docker-compose-services/mongodb)**  
**Developed and maintained by [Oblak Studio](https://github.com/oblakstudio)**
