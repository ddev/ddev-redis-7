
#ddev-generated - Do not modify this file; your modifications will be overwritten.

### DDEV-injected base Dockerfile contents
FROM redis:7.2.0-alpine as base

# Copy our custom entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

# Remove redis benchmark
RUN rm -rf /usr/local/bin/redis-benchmark

# Remove the unneded files to slim down the image
RUN find /usr/share/zoneinfo/ -type d -mindepth 1 -maxdepth 1 -exec rm -rf {} \;
RUN find /usr/share/zoneinfo -type f | grep -E -v 'UTC|\.' | xargs rm -f
RUN rm -rf /lib/apk /lib/libapk.so*

# Copy everything from scratch
FROM scratch as release
COPY --from=base / /

ENTRYPOINT ["docker-entrypoint.sh"]
