###
# Copyright (c) Mainflux
#
# This file is part of iotagent-json and is published under GNU Affero General Public License
# See the included LICENSE file for more details.
###

FROM centos:7

MAINTAINER iaoiui <iaoiui0727@gmail.com>

ARG NODEJS_VERSION=8

COPY . /opt/iotajson/
WORKDIR /opt/iotajson

RUN yum update -y && \
  yum install -y epel-release && yum update -y epel-release && \
  echo "INFO: Building node and npm..." && \
  curl -sL "https://rpm.nodesource.com/setup_${NODEJS_VERSION}.x" | bash - && \
  yum install -y gcc-c++ make yum-utils git nodejs  && \
  # If we not define node version, use the official for the SO
  [[ "${NODEJS_VERSION}" == "" ]] && export NODEJS_VERSION="$(repoquery --qf '%{VERSION}' nodejs.x86_64)" || echo "INFO: Using specific node version..." && \
  echo "***********************************************************" && \
  echo "USING NODEJS VERSION <${NODEJS_VERSION}>" && \
  echo "***********************************************************" && \
  cd /opt/iotajson && npm install --production 

ENTRYPOINT bin/iotagent-json config.js

