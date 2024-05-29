#!/bin/bash

# Define the SeisComP version and package filename
SEISCOMP_VERSION="4.0.0"
SEISCOMP_PACKAGE="seiscomp-${SEISCOMP_VERSION}-ubuntu20.04-x86_64.tar.gz"

# Check if the working directory is empty
if [ -z "$(ls -A)" ]; then
    echo "Working directory is empty. Proceeding with installation."
else
    echo "Working directory is not empty. Please move or remove existing files before proceeding."
    exit 1
fi

# Download and extract SeisComP package
wget "https://storage.googleapis.com/seismic-processing/${SEISCOMP_PACKAGE}"
tar xzf ${SEISCOMP_PACKAGE}

# Extract additional files
tar xzf seiscomp-maps.tar.gz
tar xzf "seiscomp-${SEISCOMP_VERSION}-doc.tar.gz"

# Install dependencies
~/seiscomp/bin/seiscomp install-deps base
~/seiscomp/bin/seiscomp install-deps mariadb-server
~/seiscomp/bin/seiscomp install-deps mysql-server

# Set environment variables
echo "export SEISCOMP_ROOT=~/seiscomp" >> ~/.bashrc
echo "export PATH=~/seiscomp/bin:\$PATH" >> ~/.bashrc
echo "export LD_LIBRARY_PATH=~/seiscomp/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export PYTHONPATH=~/seiscomp/lib/python:\$PYTHONPATH" >> ~/.bashrc
echo "export MANPATH=~/seiscomp/share/man:\$MANPATH" >> ~/.bashrc
echo "export LC_ALL=C" >> ~/.bashrc

# Source the updated .bashrc file
source ~/.bashrc

# Print a success message
echo "SeisComP $SEISCOMP_VERSION installed successfully!"