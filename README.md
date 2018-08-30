# docker-ubuntu-mate-desktop-nomachine
Ubuntu Desktop 16.04 (MATE) Dockerfile with NoMachine remote access

There are three tags available:

#### latest
pure ubuntu with firefox and basic linux tools

#### pycharm 
latest+ pycharm IDE. To use pycharm, open command line:
```
pycharm
```
Or you can put it at desktop 
```
sudo ln /usr/bin/pycharm ~/Desktop/pycharm
```

#### gpu 

To run this, need to use nvidia-docker instead of docker in usage. 
A lot of ML libaries(Tensorflow, pytorch, sklearn, xgboot, jupyterlab, ...) are installed.


# How to run
## Build

```
git clone https://github.com/rewreu/nomachine.git
cd docker-ubuntu-mate-desktop-nomachine
docker build -t=rewreu/nomachine .
```
## Docker pull command
```
docker pull rewreu/nomachine
```

## Enviroment vaiables
USER -> user for the nomachine login
PASSWORD -> password for the nomachine login

## Usage

```
docker run -d -p 4000:4000 --name desktop -e PASSWORD=password -e USER=user --cap-add=SYS_PTRACE rewreu/nomachine
```

## Connect to the container

Download the NoMachine client from: https://www.nomachine.com/download, install the client, create a new connection to your public ip, port 4000, NX protocol, use enviroment user and password for authentication (make sure to setup enviroment variables for that)
