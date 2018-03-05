FROM ubuntu:xenial
RUN apt-get -y update
RUN apt-get install -y fortunes binutils gcc-4.7 g++-4.7 gfortran-4.7 git cmake cmake-data liblapack-dev ipython python-dev libxml2-dev libx11-6 libxext6 libxt6 libxmu6 python-numpy python-matplotlib python3-dev python3-numpy python3-matplotlib moreutils tree wget software-properties-common

RUN dpkg --add-architecture i386
RUN apt-get update -qq
RUN apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 -y
RUN apt-get install sudo -y

RUN wget https://raw.githubusercontent.com/casadi/python-lib-template/master/.travis-setup.sh && chmod +x .travis-setup.sh
ENV WINEENV py27

RUN "./.travis-setup.sh"
ENV NUMPYVERSION 1.9.1

RUN wget -O numpy.exe https://github.com/casadi/testbot/releases/download/perpetual/numpy-$NUMPYVERSION-sse2.exe
RUN /opt/wine-staging/bin/wine C:/Python27/Scripts/easy_install.exe numpy.exe && rm numpy.exe

RUN apt-get install -q -y mingw-w64 
RUN apt-get install -q -y mingw-w64 g++-mingw-w64 gcc-mingw-w64 gfortran-mingw-w64 mingw-w64-tools
RUN apt-get install -q -y valgrind zip

RUN wget http://downloads.rclone.org/rclone-current-linux-amd64.zip
RUN unzip rclone-current-linux-amd64.zip
RUN cd rclone-*-linux-amd64 && sudo cp rclone /usr/sbin/ && sudo chown root:root /usr/sbin/rclone && sudo chmod 755 /usr/sbin/rclone
COPY .rclone.conf.template /root

RUN apt-get install gcovr gettext-base elfutils -y

RUN echo 'rclone_setup() { envsubst < /root/.rclone.conf.template > /root/.rclone.conf; } ; export -f rclone_setup' > /opt/meco_setup

RUN wget http://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh
RUN chmod +x miniconda.sh
ENV PATH="/root/miniconda2/bin:${PATH}"
RUN ./miniconda.sh -b
RUN conda update --yes conda
RUN conda create --yes -n condapy3.6 python=3.6 numpy=1.11 scipy matplotlib pip
RUN conda create --yes -n condapy2.7 python=2.7 numpy=1.9 scipy matplotlib pip

RUN apt-get install -y docker.io

RUN apt-get install -y doxygen graphviz ragel
RUN git clone https://github.com/meco-group/mtocpp
RUN cd mtocpp && mkdir build && cd build && cmake .. && make && cd ../..

