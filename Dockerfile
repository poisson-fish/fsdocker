FROM ubuntu:xenial

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1E9377A2BA9EF27F
RUN echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu xenial main" >> /etc/apt/sources.list
RUN apt update && apt-get upgrade -y && apt-get install -y --install-recommends ninja-build wget libalut-dev libapr1-dev libaprutil1-dev libatk1.0-dev libboost-all-dev libcairo2-dev libcollada-dom2.4-dp-dev libcurl4-openssl-dev libdbus-glib-1-dev libfreetype6-dev libgl1-mesa-dev libglu1-mesa-dev libgtk2.0-dev libjpeg-dev libjsoncpp-dev libnghttp2-dev libogg-dev libopenal-dev libpangox-1.0-dev libpng-dev libsdl1.2-dev libssl-dev libstdc++6 liburiparser-dev libvorbis-dev libx11-dev libxinerama-dev libxml2-dev libxmlrpc-epi-dev libxrender-dev zlib1g-dev sudo bison bzip2 cmake curl doxygen flex g++-6 gdb m4 moreutils pkg-config python python-dev python-pip locales
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 6 --slave /usr/bin/g++ g++ /usr/bin/g++-6 --slave /usr/bin/gcov gcov /usr/bin/gcov-6
RUN update-alternatives --config gcc
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
RUN echo "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-7 main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y clang-7 libfuzzer-7-dev libc++-7-dev libc++abi-7-dev 
RUN ln -s /usr/bin/clang-7 /usr/bin/clang
RUN ln -s /usr/bin/clang++-7 /usr/bin/clang++
RUN pip install --upgrade pip
RUN pip install autobuild mercurial

ENV VERSION=0.16.0 
RUN curl -sSL https://github.com/facebook/infer/releases/download/v$VERSION/infer-linux64-v$VERSION.tar.xz | tar -C /opt -xJ
RUN ln -s "/opt/infer-linux64-v$VERSION/bin/infer" /usr/local/bin/infer

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_AGENT_HOME=/home/${user}

ENV JENKINS_AGENT_HOME ${JENKINS_AGENT_HOME}

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"

# setup SSH server
RUN apt-get install --no-install-recommends -y openssh-server \
    && rm -rf /var/lib/apt/lists/*
RUN sed -i /etc/ssh/sshd_config \
        -e 's/#PermitRootLogin.*/PermitRootLogin no/' \
        -e 's/#RSAAuthentication.*/RSAAuthentication yes/'  \
        -e 's/#PasswordAuthentication.*/PasswordAuthentication no/' \
        -e 's/#SyslogFacility.*/SyslogFacility AUTH/' \
        -e 's/#LogLevel.*/LogLevel INFO/' && \
    mkdir /var/run/sshd

VOLUME "${JENKINS_AGENT_HOME}" "/tmp" "/run" "/var/run"
WORKDIR "${JENKINS_AGENT_HOME}"

COPY setup-sshd /usr/local/bin/setup-sshd

EXPOSE 22

ENTRYPOINT ["setup-sshd"]
