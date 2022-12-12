FROM debian:11-slim
ENV  DEBIAN_FRONTEND=noninteractive
RUN  apt update -yqq && apt install -yqq --no-install-recommends debhelper-compat make fakeroot gnupg g++ build-essential
RUN  apt install -yqq --no-install-recommends dh-make
WORKDIR /usr/local/tmp/Hello_world_build
COPY . .
CMD cd helloworld-1.0 && ./build.sh
