FROM ubuntu:xenial
RUN apt-get update
RUN apt-get upgrade
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1E9377A2BA9EF27F
RUN echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu xenial main" >> /etc/apt/sources.list
RUN apt update
RUN apt-get install -y --install-recommends sudo bison bzip1 cmake curl doxygen flex g++-6 gdb m4 mercurial moreutils pkg-config python python-dev python-pip
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 6 --slave /usr/bin/g++ g++ /usr/bin/g++-6 --slave /usr/bin/gcov gcov /usr/bin/gcov-6
RUN update-alternatives --config gcc
RUN apt install -y --install-recommends libalut-dev libapr1-dev libaprutil1-dev libatk1.0-dev libboost-all-dev libcairo2-dev libcollada-dom2.4-dp-dev libcurl4-openssl-dev libdbus-glib-1-dev libfreetype6-dev libgl1-mesa-dev libglu1-mesa-dev libgtk2.0-dev libjpeg-dev libjsoncpp-dev libnghttp2-dev libogg-dev libopenal-dev libpangox-1.0-dev libpng-dev libsdl1.2-dev libssl-dev libstdc++6 liburiparser-dev libvorbis-dev libx11-dev libxinerama-dev libxml2-dev libxmlrpc-epi-dev libxrender-dev zlib1g-dev
RUN pip install --upgrade pip
RUN pip install autobuild

