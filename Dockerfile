FROM ubuntu:14.04
RUN apt-get -y update && apt-get install -y fortunes binutils gcc g++ gfortran git cmake cmake-data liblapack-dev ipython python-dev libxml2-dev

RUN sudo apt-get update -qq
RUN sudo apt-get remove -qq -y mingw32
RUN echo "deb-src http://archive.ubuntu.com/ubuntu vivid main restricted universe multiverse" | sudo tee --append  /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu vivid main restricted universe multiverse" | sudo tee --append  /etc/apt/sources.list

RUN echo "Package: *" | sudo tee --append /etc/apt/preferences.d/mytest
RUN echo "Pin: release n=trusty" | sudo tee --append /etc/apt/preferences.d/mytest
RUN echo "Pin-priority: 700" | sudo tee --append /etc/apt/preferences.d/mytest

RUN echo "Package: *" | sudo tee --append /etc/apt/preferences.d/mytest  
RUN echo "Pin: release n=vivid" | sudo tee --append /etc/apt/preferences.d/mytest  
RUN echo "Pin-priority: 600" | sudo tee --append /etc/apt/preferences.d/mytest  

RUN sudo apt-get update -qq
RUN sudo apt-get install -q -y -t vivid mingw-w64 
RUN sudo apt-get install -q -y -t vivid mingw-w64 g++-mingw-w64 gcc-mingw-w64 gfortran-mingw-w64 mingw-w64-tools
