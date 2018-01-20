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
RUN apt-get install m4

# GMP LIB
RUN wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.bz2
RUN tar -xvf gmp-6.1.2.tar.bz2 
RUN rm -f gmp-6.1.2.tar.bz2 
RUN cd ./gmp-6.1.2/ \
 && ./configure \
 && make \
 && make install \
 && cd ../
