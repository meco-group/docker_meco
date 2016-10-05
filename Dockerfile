FROM ubuntu:14.04
RUN apt-get -y update && apt-get install -y fortunes binutils gcc g++ gfortran git cmake cmake-data liblapack-dev ipython python-dev libxml2-dev

