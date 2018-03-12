#!/bin/bash

# Bootstrap example script
# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

# - The first parameter for the Bootstrap Script is the USER.
USER=$1
if [ "$USER" == "" ]; then
    exit 1
fi
# ----------------------------------------------------------------------------


# This example script will do the following:
# - create one directory for the user $USER in a BASE_DIRECTORY (see below)´

# Start the Bootstrap Process
echo "bootstrap process running for user $USER ..."

# Base Directory: All Directories for the user will be below this point
BASE_DIRECTORY=/volumes

# User Directory: That's the private directory for the user to be created, if none exists
USER_DIRECTORY=$BASE_DIRECTORY/$USER

if [ -d "$USER_DIRECTORY" ]; then
    echo "...directory for user already exists. skipped"
else
    echo "...creating a directory for the user: $USER_DIRECTORY"
    #/home/jovyan
    mkdir $USER_DIRECTORY
fi

# Config Directory: That's the directory where configuration and authentication files are created, if none exists 
CONFIG_DIRECTORY=$USER_DIRECTORY/config

if [ -d "$CONFIG_DIRECTORY" ]; then
    #setup config
    mkdir -p $CONFIG_DIRECTORY
fi

# Settings File: That's the file for the registry Git values to be created, if none exists 
SETTINGS_FILE=$CONFIG_DIRECTORY/settings.json

if [ ! -f "$SETTINGS_FILE" ]; then
    echo "...creating a file: $SETTINGS_FILE"
    touch $SETTINGS_FILE
fi

# Gitconfig File: That's the file for the Git configuration data to be created, if none exists 
GITCONFIG_FILE=$CONFIG_DIRECTORY/gitconfig

if [ ! -f "$GITCONFIG_FILE" ]; then
    echo "...creating a file: $GITCONFIG_FILE"
    touch $USER_DIRECTORY/config/gitconfig
fi

# SSH Directory: That's the directory for the SSH keys to be created, if none exists 
SSH_DIRECTORY=$CONFIG_DIRECTORY/ssh

if [ ! -d "$SSH_DIRECTORY" ]; then
    echo "...creating a directory for the user: $SSH_DIRECTORY"
    mkdir $SSH_DIRECTORY
fi

# SSH File: That's the files for the SSH keys to be created, if none exists 
SSH_FILE=$SSH_DIRECTORY/id_rsa

if [ ! -f "$SSH_FILE" ]; then
    echo "...generating a new SSH key"
    ssh-keygen -t rsa -f $SSH_DIRECTORY/id_rsa -q -N ""
fi

cat > $USER_DIRECTORY/config/ssh/config <<EOL
Host *
    StrictHostKeyChecking no
    IdentityFile ~/.ssh/id_rsa
EOL

# Work Directory: That's the directory for the repositories and Jupyter Notebook files to be created, if none exists 
WORK_DIRECTORY=$USER_DIRECTORY/work

if [ ! -d "$WORK_DIRECTORY" ]; then
    echo "...creating a directory for the user: $WORK_DIRECTORY"
    mkdir -p $WORK_DIRECTORY
fi

# Change owner: grant access and read/write permission for all users 
chown -R 1000 $USER_DIRECTORY

exit 0