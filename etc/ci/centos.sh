#!/bin/sh

set -eu

yum update -y
yum install -y git \
              vim \
              unzip \
              which \
              make \
              wget \
              curl \
              gcc \
              bash \
              sudo
