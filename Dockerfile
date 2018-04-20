#FROM ubuntu:16.04
FROM ubuntu:17.10

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>
#https://github.com/jupyter/docker-stacks/blob/master/base-notebook/Dockerfile

###################
USER root
###################

# See https://github.com/sagemathinc/cocalc/issues/921
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV TERM screen

# So we can source (see http://goo.gl/oBPi5G)
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Ubuntu softwares
RUN \
     apt-get update \
  && apt-get install -y \
       software-properties-common \
       wget \
       git \
       python \
       python-pip \
       make \
       g++ \
       sudo \
       subversion \
       ssh \
       m4 \
       libpq5 \
       libpq-dev \
       build-essential \
       gfortran \
       automake \
       dpkg-dev \
       libssl-dev \
       imagemagick \
       libcairo2-dev \
       libcurl4-openssl-dev \
       graphviz \
       smem \
       python3-yaml \
       locales \
       locales-all

## create password-less user
RUN useradd -m main && echo "main:main" | chpasswd && adduser main sudo
RUN echo "main:main" | chpasswd && adduser main sudo

#### without password
RUN passwd --delete main

#### MAIN USER ####
USER main
###################

# upgrade pip
RUN sudo pip install --upgrade pip
# upgrade numpy
RUN pip install --user --upgrade numpy

# Jupyter from pip (since apt-get jupyter is ancient)
RUN \
  sudo pip install "ipython<6" jupyter

RUN jupyter notebook --generate-config
ADD jupyter_notebook_config.py jupyter_notebook_config.py
RUN cp jupyter_notebook_config.py /home/main/.jupyter/
RUN sudo pip install plotly
RUN sudo apt-get install -y python-scipy
RUN sudo pip install scipy
RUN sudo pip install sympy

# jupyter nbextensions (enable)
RUN sudo pip install jupyter_contrib_nbextensions
RUN sudo pip install jupyter_nbextensions_configurator

RUN git clone \
               https://github.com/ipython-contrib/jupyter_contrib_nbextensions \
               /home/main/jupyter_contrib_nbextensions
RUN mkdir /home/main/.ipython

RUN cp -rf \
            /home/main/jupyter_contrib_nbextensions/src/jupyter_contrib_nbextensions/nbextensions/ \
            /home/main/.ipython/

#### MAIN USER ####
USER main
###################

WORKDIR /home/main

# jupyter nbextensions (enable)
RUN jupyter-nbextensions_configurator enable --user

# enable spesific nbextension from start
RUN \
     jupyter nbextension enable hide_input_all/main \
  && jupyter nbextension enable livemdpreview/livemdpreview \
  && jupyter nbextension enable rubberband/main \   
  && jupyter nbextension enable toc2/main \   
  && jupyter nbextension enable varInspector/main \   
  && jupyter nbextension enable varInspector/main \   
  && jupyter nbextension enable collapsible_headings/main \   
  && jupyter nbextension enable hinterland/hinterland \   
  && jupyter nbextension enable snippets_menu/main \   
  && jupyter nbextension enable execute_time/ExecuteTime \   
  && jupyter nbextension enable hide_input/main \   
  && jupyter nbextension enable runtools/main \   
  && jupyter nbextension enable toggle_all_line_numbers/main \
  && jupyter nbextension enable equation-numbering/main
  
# clone Titresim_ve_Dalgalar itself
# then move dersnotlari to main folder
# then make .ipynb files trusted
RUN \
     git clone https://github.com/mkarakoc/Titresim_ve_Dalgalar_Linux.git \
 && mv /home/main/Titresim_ve_Dalgalar_Linux/Titresim_ve_Dalgalar_ders_notlarini_acmak_icin_bu_dosyayi_acin.ipynb /home/main/ \
 && rm -rf /home/main/Titresim_ve_Dalgalar_Linux \
 && jupyter trust /home/main/*.ipynb

# UPDATE Docker file on GitHub manually, to rebuilt mybinder image.
# RUN 1 2 3 4 5 6
