ARG ZYBOTVERSION="latest"
ARG GITHUBOWNER="computeronix"
ARG GITHUBREPO="zyb0t"
ARG GBINSTALLLOC="/opt/gunbot"
ARG GBMOUNT="/mnt/gunbot"
ARG ZYBOT="zyb0t-linux.zip"
ARG ZYBOTHASH="4fb564384a355f3f0a3f218663e2a23f-docker"
ARG GUNBOTVERSION
ARG GBPORT=5000
ARG MAINTAINER="computeronix"
ARG WEBSITE="https://hub.docker.com/r/computeronix/zyb0t"
ARG DESCRIPTION="(Unofficial) zyb0t Docker Container - ${GUNBOTVERSION} - ${ZYBOTVERSION}

#SCRATCH WORKSPACE FOR BUILDING IMAGE
FROM --platform="linux/amd64" debian:bullseye AS zybot-builder
ARG ZYBOTVERSION
ARG GITHUBOWNER
ARG GITHUBREPO
ARG GBINSTALLLOC
ARG GBMOUNT

WORKDIR /tmp

#BUILDING IMAGE
#update mirrors and install packages
RUN apt-get update && apt-get install -y wget jq unzip \
  #remove mirrors
  && rm -rf /var/lib/apt/lists/* \
  #pull ${ZYBOTVERSION} from official GitHub and extract linux client
  && wget -q -nv -O zybot.zip $(wget -q -nv -O- https://api.github.com/repos/${GITHUBOWNER}/${GITHUBREPO}/releases/${ZYBOTVERSION} 2>/dev/null |  jq -r '.assets[] | select(.browser_download_url | contains("linux")) | .browser_download_url') \
  && unzip -d . zybot.zip \
  && mkdir gunbot \
  && mv zyb0t-linux gunbot \
  #injecting into custom.sh
  #check for zybot directory
  && printf "if [ ! -d ${GBMOUNT}/zybot ]; then \n" >> gunbot/custom.sh \
  && printf "	mkdir ${GBMOUNT}/zybot\n" >> gunbot/custom.sh \
  && printf "fi\n" >> gunbot/custom.sh \
  && printf "ln -sf ${GBMOUNT}/zybot ${GBINSTALLLOC}/zybot\n" >> gunbot/custom.sh \
  #check for zybotconfig.js file
  && printf "ln -sf ${GBMOUNT}/zybotconfig.js ${GBINSTALLLOC}/zybotconfig.js\n" >> gunbot/custom.sh \
  && printf "if [ -f ${GBINSTALLLOC}/zybotconfig.js ]; then \n" >> gunbot/custom.sh \
  #inject zybot_config -> enable gunbot_directory
  && printf "jq '.gunbot_directory = \"${GBINSTALLLOC}\"' ${GBINSTALLLOC}/zybotconfig.js > /tmp/zybotconfig2.js\n" >> gunbot/custom.sh \
  && printf "cat /tmp/zybotconfig2.js > ${GBINSTALLLOC}/zybotconfig.js\n" >> gunbot/custom.sh \
  && printf "fi\n" >> gunbot/custom.sh \
  #check for gunbot_console.log file
  && printf "ln -sf ${GBMOUNT}/gunbot_console.log ${GBINSTALLLOC}/gunbot_console.log\n" >> gunbot/custom.sh \
  #overwrite runner.sh bash script
  && printf "#!/bin/bash\n" > gunbot/runner.sh \
  #run gunbot
  && printf "${GBINSTALLLOC}/gunthy-linux > gunbot_console.log 2>&1 &\n" >> gunbot/runner.sh \
  #run zyb0t
  && printf "${GBINSTALLLOC}/zyb0t-linux\n" >> gunbot/runner.sh

#BUILD THE RUN IMAGE
FROM --platform="linux/amd64" computeronix/gunbot:${GUNBOTVERSION}
ARG MAINTAINER
ARG WEBSITE
ARG DESCRIPTION
ARG GBINSTALLLOC
ARG GBPORT
ARG ZYBOTHASH
ENV GUNBOTLOCATION=${GBINSTALLLOC}

LABEL \
  maintainer="${MAINTAINER}" \
  website="${WEBSITE}" \
  description="${DESCRIPTION}"

COPY --from=zybot-builder /tmp/gunbot ${GBINSTALLLOC}

WORKDIR ${GBINSTALLLOC}

RUN mkdir -p /var/lib/dbus/ \
  && printf "${ZYBOTHASH}" > /var/lib/dbus/machine-id \
  && chmod +x "${GBINSTALLLOC}/custom.sh" \
  && chmod +x "${GBINSTALLLOC}/runner.sh"

EXPOSE ${GBPORT}
CMD ["bash","-c","${GUNBOTLOCATION}/startup.sh"]
