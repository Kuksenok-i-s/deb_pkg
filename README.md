# How to run
I decided to use docker image approach to finish this task,
because this provides more portability
than VM approach, ot just a executable script.
And  more this approach allows you to get same binary on different
systems with reasonably small overhead.

## Build image
```bash
# execute this in main project directory
docker build -t build_hello_world .
```

### Example output
```bash
Sending build context to Docker daemon  83.46kB
Step 1/7 : FROM debian:11-slim
##################
Step 7/7 : CMD cd helloworld-1.0 && ./build.sh
 ---> Running in 014adfd73ef9
Removing intermediate container 014adfd73ef9
 ---> eff120ceb07f
Successfully built eff120ceb07f
Successfully tagged build_hello_world:latest
```
Just want to mention this a demonstrative repository for integration into Gitlab CI or anything similar Dockerfile must be changed
to support [build_args](https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg)

## 
```bash
# finally  make sources and binary packages
docker run \
  -e USER_ID=$(id $(whoami) -u) \ # Real user id
  -e GROUP_ID=$(id $(whoami) -g)  \ # Real group id
  -v $(pwd)/binary:/local/builds/binary \ # Binary output
  -v $(pwd)/sources:/local/builds/sources \ # Source output
  build_hello_world
```

Example output:
```bash
user_id 1000 and group_id 1000 are defined
setting file permissions with  "chown -R 1000:1000 /local/builds"
binary files
total 4
-rw-r--r-- 1 1000 1000 2196 Dec 12 12:21 helloworld_1.0-1_amd64.deb
source files
total 16
-rw-r--r-- 1 1000 1000 7780 Dec 12 12:21 helloworld_1.0-1.debian.tar.xz
-rw-r--r-- 1 1000 1000  822 Dec 12 12:21 helloworld_1.0-1.dsc
-rw-r--r-- 1 1000 1000 1155 Dec 12 12:21 helloworld_1.0.orig.tar.gz
```

# Results

After execution you should be able to find all required files in `binary` and `sources` directories 
