# docker-ubuntu-mate-desktop-nomachine 6.10
Ubuntu Desktop 18.04 (MATE) Dockerfile with NoMachine 6.10 remote access

There are three tags available:

#### latest
pure ubuntu with firefox, chrome and chromium-browser and basic linux tools

#### mega
with mega.nz cmd and dropbox 



# How to run
## Build

```
git clone https://github.com/spamtram10/nomachine.git
cd nomachine
docker build -t=spamtram10/nomachine .
```
## Docker pull command
```
docker pull spamtram10/nomachine
```

## Enviroment vaiables
USER -> user for the nomachine login
PASSWORD -> password for the nomachine login

## Usage

```
docker run -d -p 4000:4000 --name nomachine -e PASSWORD=password -e USER=user --cap-add=SYS_PTRACE --shm-size=1g lordcris/nomachine
```

## Connect to the container

Download the NoMachine client from: https://www.nomachine.com/download, install the client, create a new connection to your public ip, port 4000, NX protocol, use enviroment user and password for authentication (make sure to setup enviroment variables for that)

## Timezone issue
Docker always uses UTC 0. 

To avoid it, you can use the following in Ubuntu:
```
docker run -d -p 4000:4000 --name desktop \
-e PASSWORD=password -v /etc/localtime:/etc/localtime:ro \
-e USER=user --cap-add=SYS_PTRACE --shm-size=1g lordcris/nomachine
```


