FROM andrewosh/binder-base

MAINTAINER Jeremy Freeman <freeman.jeremy@gmail.com>

USER root

## Add dependency
#RUN apt-get update

RUN rm -f ~/start-notebook.sh
ADD start-notebook.sh start-notebook.sh
RUN chmod +x ~/start-notebook.sh

USER main

RUN jupyter notebook --generate-config
ADD jupyter_notebook_config.py jupyter_notebook_config.py
RUN cp jupyter_notebook_config.py /home/main/.jupyter/
RUN pip install plotly
