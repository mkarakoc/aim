FROM andrewosh/binder-base

MAINTAINER Jeremy Freeman <freeman.jeremy@gmail.com>

USER root

### Add dependency
###RUN apt-get update

##RUN rm -f ~/start-notebook.sh
##ADD start-notebook.sh start-notebook.sh
##RUN chmod +x ~/start-notebook.sh

#USER main

RUN jupyter notebook --generate-config
ADD jupyter_notebook_config.py jupyter_notebook_config.py
RUN cp jupyter_notebook_config.py /home/main/.jupyter/
RUN pip install plotly

# M4: macro processing language
RUN apt-get update
RUN apt-get -y install m4

# GMP LIB
RUN wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.bz2
RUN tar -xvf gmp-6.1.2.tar.bz2 
RUN rm -f gmp-6.1.2.tar.bz2 
RUN cd ./gmp-6.1.2/ \
 && ./configure \
 && make \
 && make install \
 && cd ../

# MPFR
RUN wget http://www.mpfr.org/mpfr-current/mpfr-3.1.5.tar.gz
RUN tar -xvf mpfr-3.1.5.tar.gz
RUN rm -f mpfr-3.1.5.tar.gz
RUN cd ./mpfr-3.1.5/ \
 && ./configure
 && make
 && make install"
 && cd ../

# FLINT2
#- git clone --depth=50 --branch=master https://github.com/fredrik-johansson/flint2.git
RUN git clone https://github.com/fredrik-johansson/flint2.git
RUN cd ./flint2/ \
 && ./configure
 && make
 && make install
 && cd ../
# ARB
RUN git clone https://github.com/fredrik-johansson/arb.git
RUN cd ./arb/ \
 && ./configure
 && make
 && make install
 && cd ../
# python-flint
RUN apt-get -y install cython python-dev
RUN git clone https://github.com/fredrik-johansson/python-flint.git
RUN cd ./python-flint \
 && export LD_LIBRARY_PATH=/usr/local/include/flint:/usr/local/include/arb:$LD_LIBRARY_PATH
 && python ./setup.py build_ext --include-dirs=/usr/local/include/flint:/usr/local/include/arb --library-dirs=/usr/local/include/flint:/usr/local/include/arb
 && python setup.py install
 && cd ../
