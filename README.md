[![add-on registry](https://img.shields.io/badge/DDEV-Add--on_Registry-blue)](https://addons.ddev.com)
[![tests](https://github.com/ddev/ddev-redis-7/actions/workflows/tests.yml/badge.svg?branch=main)](https://github.com/ddev/ddev-redis-7/actions/workflows/tests.yml?query=branch%3Amain)
[![project is obsolete](https://img.shields.io/badge/maintenance-obsolete-red.svg)](https://github.com/ddev/ddev-redis-7/commits)
[![release](https://img.shields.io/github/v/release/ddev/ddev-redis-7)](https://github.com/ddev/ddev-redis-7/releases/latest)

# ddev-redis-7 (obsolete and archived)

This add-on is part of [ddev/ddev-redis](https://github.com/ddev/ddev-redis) since [v2.0.0](https://github.com/ddev/ddev-redis/releases/tag/v2.0.0). See the `README.md` in `ddev/ddev-redis` for optimized configuration and migration instructions.

This add-on is archived.

## Overview

This repository provides [Redis 7](https://redis.com) container for [DDEV](https://ddev.readthedocs.io/).

It is based on [redis:7.2-alpine](https://hub.docker.com/_/redis/tags?page=1&name=7) docker image and [DDEV custom compose files](https://ddev.readthedocs.io/en/stable/users/extend/custom-compose-files/)

## Installation

For DDEV v1.23.5 or above run

```sh
ddev add-on get ddev/ddev-redis-7
```

For earlier versions of DDEV run

```sh
ddev get ddev/ddev-redis-7
```

Then restart your project

```sh
ddev restart
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
