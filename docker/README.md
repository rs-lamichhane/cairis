# INSTRUCTION TO BUILD AND BRING UP SETUP WITH DOCKER MODIFIED FOR PROXMOX VE DOCKER (LXC)

## 1. Build docker image

By default, the cairis backend source code is fetched from github repo. The below script will help to build docker image locally.
You can specify the image version. By default, it is "latest".

```sh
./buildLocalImage.sh
```

## 2. Server startup and shutdown

To create and start containers in background mode:

```sh
docker compose up -d
```

To restart containers (after configuration changes):

```sh
docker compose restart
```

To view container logs:

```sh
docker compose logs -f
```

To stop:

```sh
docker compose stop
```

To start:

```sh
docker compose start
```

To stop and remove the containers:

```sh
docker compose down
```

Your data is persistent even you remove the containers. To completely delete all data:

```sh
$ docker volume rm cairis_cairisDocumentation cairis_cairisImage cairis_cairisMysqlData
```

## 3. User Management

### Create a user

"cairis-CAIRIS-1" is the name of docker container of the cairis server.

```sh
docker exec -t cairis-CAIRIS-1 ./addAccount.sh test@test.com test TestUser
```

### Remove a user

To remove a specific user:

```sh
docker exec -t cairis-CAIRIS-1 ./removeAccount.sh test@test.com
```

To remove all users:

```sh
docker exec -t cairis-CAIRIS-1 ./removeAccount.sh all
```

**Note**: If you get a "Duplicate entry" error when creating a user, the email already exists. Either use a different email or remove the existing user first using the removeAccount.sh script.

## 4. Troubleshooting

### Passlib/pkg_resources Warning

If you see a warning like:
```
UserWarning: pkg_resources is deprecated as an API...
```

This is just a deprecation warning from the `passlib` library and does not affect functionality. It will be addressed in future updates. You can safely ignore this warning.

### MySQL Out of Memory Error

If you see "mysqld: Out of memory" errors in the logs, the MySQL container has been configured with memory-optimized settings:
- `performance-schema=0` - Disables performance schema to save memory
- `innodb_buffer_pool_size=128M` - Sets InnoDB buffer pool to 128MB
- `table_open_cache=64` - Reduces table cache
- `max_connections=100` - Limits maximum connections

These settings are already included in the `compose.yml` file for better compatibility with resource-constrained environments.

### SSL Configuration

If you just need to append "ssl_disabled=True to /cairis.cnf." Use "nano" if it's installed else use echo to cat.
```sh
$ echo "ssl_disabled=True" >> /cairis.cnf
```

### argon2_cffi Installation

It may fail just enter to the container and run

```sh
$ docker exec -it cairis-CAIRIS-1 bash
```
and run

```sh
$ pip install argon2_cffi --break-system-packages
```

### Checking Logs

To check for errors:
```sh
$ docker compose logs --tail=50
$ docker compose logs -f  # Follow logs in real-time
```

