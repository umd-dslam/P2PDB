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
$(cmd) [OPTIONS...]
-v, --version; Set presto version
" | column -t -s ";"
}

USER_NAME=${SUDO_USER:=$USER}
USER_ID=$(id -u "${USER_NAME}")

if [ "$(uname -s)" = "Darwin" ]; then
  GROUP_ID=100
fi

if [ "$(uname -s)" = "Linux" ]; then
  GROUP_ID=$(id -g "${USER_NAME}")
  # man docker-run
  # When using SELinux, mounted directories may not be accessible
  # to the container. To work around this, with Docker prior to 1.7
  # one needs to run the "chcon -Rt svirt_sandbox_file_t" command on
  # the directories. With Docker 1.7 and later the z mount option
  # does this automatically.
  if command -v selinuxenabled >/dev/null && selinuxenabled; then
    DCKR_VER=$(docker -v|
    awk '$1 == "Docker" && $2 == "version" {split($3,ver,".");print ver[1]"."ver[2]}')
    DCKR_MAJ=${DCKR_VER%.*}
    DCKR_MIN=${DCKR_VER#*.}
    if [ "${DCKR_MAJ}" -eq 1 ] && [ "${DCKR_MIN}" -ge 7 ] ||
        [ "${DCKR_MAJ}" -gt 1 ]; then
      V_OPTS=:z
    else
      for d in "${PWD}" "${HOME}/.m2"; do
        ctx=$(stat --printf='%C' "$d"|cut -d':' -f3)
        if [ "$ctx" != svirt_sandbox_file_t ] && [ "$ctx" != container_file_t ]; then
          printf 'INFO: SELinux is enabled.\n'
          printf '\tMounted %s may not be accessible to the container.\n' "$d"
          printf 'INFO: If so, on the host, run the following command:\n'
          printf '\t# chcon -Rt svirt_sandbox_file_t %s\n' "$d"
        fi
      done
    fi
  fi
fi

# shellcheck disable=SC2034
options=$(getopt -o r:c:v:i --long rpm:,cli:,version:,incremental -n 'parse-options' -- "$@")

# shellcheck disable=SC2181
if [ $? != 0 ]; then
  echo "Failed parsing options." >&2
  exit 1
fi

while true; do
  case "$1" in
    -v | --version ) PRESTO_VERSION=$2; shift 2;;
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

RUN groupadd --non-unique -g ${GROUP_ID} ${USER_NAME}
RUN useradd -g ${GROUP_ID} -u ${USER_ID} -k /root -m ${USER_NAME}
RUN echo "${USER_NAME} ALL=NOPASSWD: ALL" >> /etc/sudoers
ENV HOME /home/${USER_NAME}

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

# By mapping the .m2 directory you can do an mvn install from
# within the container and use the result on your normal
# system.  And this also is a significant speedup in subsequent
# builds because the dependencies are downloaded only once.
docker run --rm=true -it \
  -d --net=host \
  -v "${PWD}:/home/${USER_NAME}/host${V_OPTS:-}" \
  -w "/home/${USER_NAME}" \
  -v "${HOME}/.m2:/home/${USER_NAME}/.m2${V_OPTS:-}" \
  -u "${USER_NAME}" \
  --name p2pdb-coordinator-dev \
  "${IMAGE_NAME}"
