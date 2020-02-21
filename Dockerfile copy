FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

# Configure timezone and locale to spanish and America/Bogota timezone. Change locale and timezone to whatever you want
ENV LANG="en_US.UTF-8"
ENV LANGUAGE=en_US

# Goto https://www.nomachine.com/download/download&id=10 and change for the latest NOMACHINE_PACKAGE_NAME and MD5 shown in that link to get the latest version.
ENV NOMACHINE_PACKAGE_NAME nomachine_6.9.2_1_amd64.deb
ENV NOMACHINE_BUILD 6.9
ENV NOMACHINE_MD5 86fe9a0f9ee06ee6fce41aa36674f727

RUN apt-get clean && apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8 && locale-gen en_US && \
    echo "Europe/Sofia" > /etc/timezone && \
    apt-get install -y locales && \
    sed -i -e "s/# $LANG.*/$LANG.UTF-8 UTF-8/" /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$LANG && \
    apt-get update -y && \
    apt-get install -y software-properties-common python-pycurl python-apt python3-software-properties sudo && \
    add-apt-repository universe && \
    apt-get update -y && \
    
    apt-get install -y xterm pulseaudio curl \
    libgconf2-4 iputils-ping libnss3 libxss1 wget xdg-utils libpango1.0-0 fonts-liberation \
    mate-desktop-environment-extras firefox htop nano git vim && \
    
    curl -fSL "http://download.nomachine.com/download/${NOMACHINE_BUILD}/Linux/${NOMACHINE_PACKAGE_NAME}" -o nomachine.deb \
&& echo "${NOMACHINE_MD5} *nomachine.deb" | md5sum -c - && dpkg -i nomachine.deb && sed -i "s|#EnableClipboard both|EnableClipboard both |g" /usr/NX/etc/server.cfg && \

    curl -s https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o google-chrome-stable_current_amd64.deb && \

    apt -y install ./google-chrome-stable_current_amd64.deb && \
    rm ./google-chrome-stable_current_amd64.deb

ADD nxserver.sh /

ENTRYPOINT ["/nxserver.sh"]