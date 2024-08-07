# Copyright 2017 - 2024 Vladimir Roncevic <elektron.ronca@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM debian:12
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq --no-install-recommends \
    tree \
    htop \
    wget \
    unzip \
    ca-certificates \
    openssl

RUN wget https://github.com/vroncevic/sh_util/archive/1.0.zip
RUN unzip 1.0.zip
RUN find /sh_util-1.0/ -name "*.editorconfig" -type f -exec rm -Rf {} \;
RUN mkdir -p /root/scripts/sh_util/ver.1.0/
RUN cp -R /sh_util-1.0/sh_tool/bin/   /root/scripts/sh_util/ver.1.0/
RUN cp -R /sh_util-1.0/sh_tool/conf/  /root/scripts/sh_util/ver.1.0/
RUN cp -R /sh_util-1.0/sh_tool/log/   /root/scripts/sh_util/ver.1.0/
RUN rm -Rf v1.0.zip sh_util-1.0
RUN mkdir /sh_tool/
COPY sh_tool /sh_tool/
RUN find /sh_tool/ -name "*.editorconfig" -type f -exec rm -Rf {} \;
RUN mkdir -p /root/scripts/githuber/ver.4.2/
RUN mkdir /root/bin/
RUN cp -R /sh_tool/bin/   /root/scripts/githuber/ver.4.2/
RUN cp -R /sh_tool/conf/  /root/scripts/githuber/ver.4.2/
RUN cp -R /sh_tool/log/   /root/scripts/githuber/ver.4.2/
RUN rm -Rf /sh_tool/
RUN chmod -R 755 /root/scripts/githuber/ver.4.2/
RUN ln -s /root/scripts/githuber/ver.4.2/bin/githuber.sh /root/bin/githuber
RUN tree /root/scripts/githuber/ver.4.2/
