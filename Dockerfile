FROM ubuntu:18.04


ENV DEBIAN_FRONTEND=noninteractive

ENV NOMACHINE_PACKAGE_NAME nomachine_6.9.2_1_amd64.deb
ENV NOMACHINE_BUILD 6.9
ENV NOMACHINE_MD5 86fe9a0f9ee06ee6fce41aa36674f727

# Helpers
RUN apt-get update && apt-get install -y vim xterm pulseaudio cups 

RUN apt-get -y dist-upgrade 
RUN apt-get install -y  mate-desktop-environment-core mate-desktop-environment mate-indicator-applet ubuntu-mate-themes ubuntu-mate-wallpapers chromium-browser firefox nano sudo

RUN apt-get install -y wget

RUN curl -fSL "http://download.nomachine.com/download/${NOMACHINE_BUILD}/Linux/${NOMACHINE_PACKAGE_NAME}" -o nomachine.deb \
&& echo "${NOMACHINE_MD5} *nomachine.deb" | md5sum -c - && dpkg -i nomachine.deb && sed -i "s|#EnableClipboard both|EnableClipboard both |g" /usr/NX/etc/server.cfg

RUN curl -s https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o google-chrome-stable_current_amd64.deb && \

    apt -y install ./google-chrome-stable_current_amd64.deb && \
    rm ./google-chrome-stable_current_amd64.deb

RUN apt-get clean
RUN apt-get autoclean

RUN echo 'pref("browser.tabs.remote.autostart", false);' >> /usr/lib/firefox/browser/defaults/preferences/vendor-firefox.js
RUN rm -rf /var/lib/apt/lists/*

RUN groupadd -r nomachine -g 433 && \
useradd -u 431 -r -g nomachine -d /home/nomachine -s /bin/bash -c "NoMachine" nomachine && \
mkdir /home/nomachine && \
chown -R nomachine:nomachine /home/nomachine && \
echo 'nomachine:nomachine' | chpasswd

RUN echo "nomachine    ALL=(ALL) ALL" >> /etc/sudoers

EXPOSE 4000

VOLUME [ "/home/nomachine" ]

ADD nxserver.sh /

RUN chmod +x /nxserver.sh

ENTRYPOINT ["/nxserver.sh"]