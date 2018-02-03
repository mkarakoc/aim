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

# M4: macro processing language
RUN sudo apt-get --no-install-recommends -y install m4

# create folder for following libs
RUN mkdir /home/main/pylibs

# GMP LIB
RUN \
     cd /home/main/pylibs \
  && wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.bz2 \
  && tar -xvf gmp-6.1.2.tar.bz2 \
  && rm -f gmp-6.1.2.tar.bz2 \
  && cd ./gmp-6.1.2/ && ./configure && make && sudo make install && cd ../../

# MPFR
RUN \
     cd /home/main/pylibs \
  && wget http://www.mpfr.org/mpfr-current/mpfr-4.0.0.tar.gz \
  && tar -xvf mpfr-4.0.0.tar.gz \
  && rm -f mpfr-4.0.0.tar.gz \
  && cd ./mpfr-4.0.0/ && ./configure && make && sudo make install && cd ../../

# FLINT2
#- git clone --depth=50 --branch=master https://github.com/fredrik-johansson/flint2.git
RUN \
     cd /home/main/pylibs \
  && git clone https://github.com/fredrik-johansson/flint2.git \
  && cd ./flint2/ && ./configure && make && sudo make install && cd ../../

# ARB
RUN \
     cd /home/main/pylibs \
  && git clone https://github.com/fredrik-johansson/arb.git \
  && cd ./arb/ && ./configure && make && sudo make install && cd ../../

##############
# python-flint
##############
RUN sudo apt-get --no-install-recommends -y install cython python-dev

RUN \
     cd /home/main/pylibs \
  && git clone https://github.com/fredrik-johansson/python-flint.git \
  && cd ./python-flint \
  && sudo python ./setup.py build_ext --include-dirs=/home/main/pylibs/flint2:/home/main/pylibs/arb \
                                      --library-dirs=/home/main/pylibs/flint2:/home/main/pylibs/arb \
  && sudo python setup.py install \
  && cd ../../
 
# flint path for PYTHON 2
#ENV export LD_LIBRARY_PATH=/home/main/flint2:/home/main/arb:$LD_LIBRARY_PATH
RUN cp /home/main/pylibs/flint2/libflint.so.13 anaconda2/lib/ \
 && cp -rf /home/main/pylibs/arb/libarb.so.2* /home/main/anaconda2/lib/

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

# jupyter notebook
RUN jupyter notebook --generate-config
ADD jupyter_notebook_config.py jupyter_notebook_config.py
RUN cp jupyter_notebook_config.py /home/main/.jupyter/

# jupyter nbextensions (install)
RUN sudo /home/main/anaconda2/bin/pip install jupyter_contrib_nbextensions
RUN sudo /home/main/anaconda2/bin/pip install jupyter_nbextensions_configurator
RUN sudo /home/main/anaconda2/envs/python3/bin/pip install jupyter_contrib_nbextensions
RUN sudo /home/main/anaconda2/envs/python3/bin/pip install jupyter_nbextensions_configurator

RUN git clone \
               https://github.com/ipython-contrib/jupyter_contrib_nbextensions \
               /home/main/jupyter_contrib_nbextensions
RUN mkdir /home/main/.ipython

RUN cp -rf \
            /home/main/jupyter_contrib_nbextensions/src/jupyter_contrib_nbextensions/nbextensions/ \
            /home/main/.ipython/

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
  && jupyter nbextension enable toggle_all_line_numbers/main  
  
