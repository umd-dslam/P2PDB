#!/bin/bash
# Copyright 2019 DSLAM (http://dslam.cs.umd.edu/). All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Gets the command name without path
function cmd()
{
  basename "$0"
}

function usage()
{
  echo "\
cmd [OPTIONS...]
-v, --version; Set presto version
" | column -t -s ";"
}

# shellcheck disable=SC2034
options=$(getopt -o r:c:v:i --long rpm:,cli:,version:,incremental -n 'parse-options' -- "$@")

# shellcheck disable=SC2181
if [ $? != 0 ]; then
  echo "Failed parsing options." >&2
  exit 1
fi

while true; do
  case "$1" in
    -v | --version ) PRESTO_VERSION=$2; shift ;;
    -- ) shift; break ;;
    "" ) break ;;
    * ) echo "Unknown option provided ${1}"; usage; exit 1; ;;
  esac
done

if [ -z "${PRESTO_VERSION}" ]; then
  echo "-v/--version option is missing"
  usage
  exit 1
fi

set -xeuo pipefail

cat <<EOF
########################################
# Build Coordinator's Dev Environment
########################################

EOF

IMAGE_NAME=p2pdb/coordinator:${PRESTO_VERSION}

docker build -t "${IMAGE_NAME}" - <<UserSpecificDocker
FROM centos:7.5.1804
LABEL maintainer="gangliao@cs.umd.edu"

RUN yum update -y && \
    yum -y install java-11-openjdk java-11-openjdk-devel less vim wget curl git && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    echo OK

########################################
# Install Apache Maven
########################################

RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-3.6.3 /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV JAVA_HOME     /usr/lib/jvm/java
ENV M2_HOME       /usr/share/maven
ENV MAVEN_HOME    /usr/share/maven
ENV MAVEN_VERSION 3.6.3

########################################
# Clone Presto Source Code
########################################

RUN git clone https://github.com/DSLAM-UMD/presto /home/${USER_NAME}/coordinator/
UserSpecificDocker

cat <<EOF
########################################
# Run Coordinator's Dev Environment
########################################

EOF

#If this env varible is empty, docker will be started
# in non interactive mode
DOCKER_INTERACTIVE_RUN=${DOCKER_INTERACTIVE_RUN-"-i -t"}

# By mapping the .m2 directory you can do an mvn install from
# within the container and use the result on your normal
# system.  And this also is a significant speedup in subsequent
# builds because the dependencies are downloaded only once.
docker run --rm=true "${DOCKER_INTERACTIVE_RUN}" \
  -d --net=host \
  -v "${PWD}:/home/${USER_NAME}/host${V_OPTS:-}" \
  -w "/home/${USER_NAME}" \
  -v "${HOME}/.m2:/home/${USER_NAME}/.m2${V_OPTS:-}" \
  -u "${USER_NAME}" \
  --name p2pdb-coordinator-dev \
  "${IMAGE_NAME}"
