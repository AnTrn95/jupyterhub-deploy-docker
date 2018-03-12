ARG DOCKER_NOTEBOOK_IMAGE
FROM $DOCKER_NOTEBOOK_IMAGE
ARG JUPYTERHUB_VERSION
RUN python3 -m pip install --no-cache jupyterhub==$JUPYTERHUB_VERSION gitpython jupyter_contrib_nbextensions

USER root
RUN apt-get update && \
    apt-get install openssh-client -y
ADD githubcommit /tmp/githubcommit
RUN cd /tmp && \
    pip install githubcommit/ && \
    jupyter serverextension enable --py githubcommit && \
    jupyter nbextension install --py githubcommit && \
    jupyter nbextension enable --py githubcommit

ADD bash_profile /home/jovyan/.bash_profile
RUN chown -R jovyan: /home/jovyan/ 

USER jovyan

ENV GIT_PARENT_DIR=/home/jovyan/work \
    GIT_PUBKEY_FILE=/home/jovyan/.ssh/id_rsa.pub \
    GIT_SETTINGS_FILE=/home/jovyan/.settings.json