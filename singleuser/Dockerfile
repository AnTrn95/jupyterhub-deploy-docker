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

ADD githubcommit/config /home/jovyan/.ssh/config
ADD config/ssh /home/jovyan/.ssh
ADD bash_profile /home/jovyan/.bash_profile
RUN chown -R jovyan: /home/jovyan/

USER jovyan
RUN git config --global user.email "you@example.com" && \
    git config --global user.name "Your Name"

ENV GIT_PARENT_DIR=/home/jovyan
ENV GIT_REPO_NAME=testrepo1
ENV GIT_BRANCH_NAME=master
ENV GIT_USER=AnTrn95
ENV GIT_USER_UPSTREAM=AnTrn95
ENV GIT_EMAIL=antr.hat@gmail.com
ENV GITHUB_ACCESS_TOKEN=c099fb6ed3fc15c5d3c3c98d01577f18b44efe1f
ENV GIT_REMOTE_URL=git@github.com:AnTrn95/testrepo1.git
ENV GIT_REMOTE_UPSTREAM=AnTrn95
