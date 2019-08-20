FROM conda/miniconda3-centos7

RUN yum -y install make

RUN conda create --name ocpx python=3.6
RUN conda activate ocpx
RUN conda install matplotlib
RUN conda install scipy
RUN conda install ipython
RUN conda install pylint
RUN conda install nose
RUN pip install sphinx-gallery
