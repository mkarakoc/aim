FROM andrewosh/binder-base

MAINTAINER Jeremy Freeman <freeman.jeremy@gmail.com>

#### ROOT USER ####
USER root

RUN apt-get update && \
      apt-get -y install sudo

#RUN useradd -m main && echo "main:main" | chpasswd && adduser main sudo
RUN echo "main:main" | chpasswd && adduser main sudo

#### without password
RUN passwd --delete main
#### MAIN USER ####
USER main

RUN sudo pip3 install python-flint

RUN jupyter notebook --generate-config
ADD jupyter_notebook_config.py jupyter_notebook_config.py
RUN cp jupyter_notebook_config.py /home/main/.jupyter/
RUN sudo pip install plotly

# M4: macro processing language
RUN sudo apt-get update
RUN sudo apt-get -y install m4

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

# python-flint
RUN sudo apt-get -y install cython python-dev
RUN sudo pip install python-flint

#RUN git clone https://github.com/fredrik-johansson/python-flint.git
#RUN cd ./python-flint \
# && export LD_LIBRARY_PATH=/usr/local/include/flint:/usr/local/include/arb:$LD_LIBRARY_PATH \
# && python ./setup.py build_ext --include-dirs=/usr/local/include/flint:/usr/local/include/arb --library-dirs=/usr/local/include/flint:/usr/local/include/arb \
# && python setup.py install \
# && cd ../
