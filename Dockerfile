# https://hub.docker.com/r/hesap/
FROM hesap/aimpy:main202002270048

MAINTAINER Mesut Karakoç <mesudkarakoc@gmail.com>

# root user
USER root

# add jupyter notebooks
ADD examples    /home/main/examples
RUN chown -R main:main /home/main/examples

# main user
USER main

# working directory
WORKDIR /home/main

# jupyter notebook and its ip to use from outside of the Docker container
CMD echo '**************************************************'                          && \
    echo 'check whether the following IP exist if not change the IP in the Dockerfile' && \
    echo http://`hostname -i | awk '{print $1}'`:8080/?token=[COPY PASTE TOKEN HERE]   && \
    echo '**************************************************'                          && \
    echo                                                                               && \     
    jupyter notebook --no-browser --ip=172.17.0.2 --port=8080 
