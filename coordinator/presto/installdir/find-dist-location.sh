#!/usr/bin/env bash
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


set -xeuo pipefail

test $# -eq 2
dist_location="$1"
presto_version="$2"

if test "${dist_location}" != ""; then
    echo "${dist_location}"
    exit
fi

dist_location="https://s3.us-east-2.amazonaws.com/starburstdata/presto"

if [[ "${presto_version}" = *"-t."* ]]; then
    dist_location="${dist_location}/teradata"
else
    dist_location="${dist_location}/starburst"
fi

version_dir="$(echo "${presto_version}" | sed -ne 's/^\([0-9]\+\)-\([a-z]\)\..*$/\1\2/p')"
test "${version_dir}" != "" # since we used `sed -n`, it will output anything only if there is a match
dist_location="${dist_location}/${version_dir}"

dist_location="${dist_location}/${presto_version}"
echo "${dist_location}"
