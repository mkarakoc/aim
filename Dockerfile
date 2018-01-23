FROM andrewosh/binder-base

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

#### ROOT USER ####
USER root
###################

RUN apt-get --no-install-recommends update \
 && apt-get --no-install-recommends -y install \
            sudo \
            apt-utils

#### make MAIN user passwordless
#RUN useradd -m main && echo "main:main" | chpasswd && adduser main sudo
RUN echo "main:main" | chpasswd && adduser main sudo
RUN passwd --delete main

#### MAIN USER ####
USER main
###################

# jupyter notebook
RUN jupyter notebook --generate-config
ADD jupyter_notebook_config.py jupyter_notebook_config.py
RUN cp jupyter_notebook_config.py /home/main/.jupyter/

# M4: macro processing language
RUN sudo apt-get --no-install-recommends -y install m4

# GMP LIB
RUN wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.bz2
RUN tar -xvf gmp-6.1.2.tar.bz2 
RUN rm -f gmp-6.1.2.tar.bz2 
RUN cd ./gmp-6.1.2/ && ./configure && make && sudo make install && cd ../

# MPFR
RUN wget http://www.mpfr.org/mpfr-current/mpfr-4.0.0.tar.gz
RUN tar -xvf mpfr-4.0.0.tar.gz
RUN rm -f mpfr-4.0.0.tar.gz
RUN cd ./mpfr-4.0.0/ && ./configure && make && sudo make install && cd ../

# FLINT2
#- git clone --depth=50 --branch=master https://github.com/fredrik-johansson/flint2.git
RUN git clone https://github.com/fredrik-johansson/flint2.git
RUN cd ./flint2/ && ./configure && make && sudo make install && cd ../

# ARB
RUN git clone https://github.com/fredrik-johansson/arb.git
RUN cd ./arb/ && ./configure && make && sudo make install && cd ../

##############
# python-flint
##############
RUN sudo apt-get --no-install-recommends -y install cython python-dev

RUN git clone https://github.com/fredrik-johansson/python-flint.git
RUN cd ./python-flint \
 && python ./setup.py build_ext --include-dirs=/home/main/flint2:/home/main/arb --library-dirs=/home/main/flint2:/home/main/arb \
 && python setup.py install \
 && cd ../
 
# flint path for PYTHON 2
#ENV export LD_LIBRARY_PATH=/home/main/flint2:/home/main/arb:$LD_LIBRARY_PATH
RUN cp /home/main/flint2/libflint.so.13 anaconda2/lib/ \
 && cp -rf /home/main/arb/libarb.so.2* /home/main/anaconda2/lib/

# upgrade pip 2 and 3
RUN sudo /home/main/anaconda2/bin/pip install --upgrade pip
RUN sudo /home/main/anaconda2/envs/python3/bin/pip install --upgrade pip

# flint for PYTHON 3
RUN sudo /home/main/anaconda2/envs/python3/bin/pip install python-flint

# install plotly 
RUN sudo /home/main/anaconda2/bin/pip install plotly
RUN sudo /home/main/anaconda2/envs/python3/bin/pip install plotly

# symengine python 2 and 3
RUN sudo /home/main/anaconda2/bin/pip install symengine
RUN sudo /home/main/anaconda2/envs/python3/bin/pip install symengine

# jupyter nbextensions (install)
RUN sudo /home/main/anaconda2/bin/pip install jupyter_contrib_nbextensions
RUN sudo /home/main/anaconda2/bin/pip install jupyter_nbextensions_configurator
RUN sudo /home/main/anaconda2/envs/python3/bin/pip install jupyter_contrib_nbextensions
RUN sudo /home/main/anaconda2/envs/python3/bin/pip install jupyter_nbextensions_configurator

# jupyter nbextensions (enable)
RUN jupyter-nbextensions_configurator enable
