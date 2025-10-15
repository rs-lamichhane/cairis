# INSTRUCTION TO BUILD AND BRING UP SETUP WITH DOCKER MODIFIED FOR PROXMOX VE DOCKER (LXC)

## 1. Build docker image

By default, the cairis backend source code is fetched from github repo. The below script will help to build docker image locally.
You can specify the image version. By default, it is "latest".

```sh
./buildLocalImage.sh
```

## 2. Server startup and shutdown

To create and start containers in backgroud mode:

```sh
docker compose up -d
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

## 3. Create a user

"cairis-CAIRIS-1" is the name of docker container of the cairis server.

```sh
docker exec -t cairis-CAIRIS-1 ./addAccount.sh test@test.com test TestUser
```

## 4. Note

If you just need to append "ssl_disabled=True to /cairis.cnf." Use "nano" if it's installed else use echo to cat.
```sh
$ echo "ssl_disabled=True" >> /cairis.cnf
```

It may fail just enter to the continaer and run

```sh
$ docker exec -it cairis-CAIRIS-1 bash
```
and run

```sh
$ pip install argon2_cffi --break-system-packages
```

