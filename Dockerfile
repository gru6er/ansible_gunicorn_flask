FROM ubuntu:18.04
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install  openssh-server sudo supervisor make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev \
libgdbm-dev libnss3-dev libedit-dev libc6-dev -y \
&& wget https://www.python.org/ftp/python/3.6.13/Python-3.6.13.tgz \
&& tar -xzf Python-3.6.13.tgz \
&& cd Python-3.6.13 \
&& ./configure --enable-optimizations  -with-lto \
&& make install \
&& mkdir /run/sshd

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test \
&& echo 'test:test' | chpasswd

# RUN service ssh start
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5000

CMD ["/usr/bin/supervisord"]
