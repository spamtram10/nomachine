FROM ubuntu:18.04


ENV DEBIAN_FRONTEND=noninteractive

ENV NOMACHINE_PACKAGE_NAME nomachine_6.10.12_1_amd64.deb
ENV NOMACHINE_BUILD 6.10
ENV NOMACHINE_MD5 930ed68876b69a5a20f3f2b2c0650abc

# Helpers
RUN apt-get update && apt-get install -y vim xterm pulseaudio cups 

RUN apt-get -y dist-upgrade 
RUN apt-get install -y  apt-utils mate-desktop-environment-core mate-desktop-environment mate-indicator-applet ubuntu-mate-themes ubuntu-mate-wallpapers firefox nano sudo

RUN apt-get install -y wget curl

RUN curl -fSL "http://download.nomachine.com/download/${NOMACHINE_BUILD}/Linux/${NOMACHINE_PACKAGE_NAME}" -o nomachine.deb \
&& sed -i "s|#EnableClipboard both|EnableClipboard both |g" /usr/NX/etc/server.cfg

# Set the Chrome repo.
# RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#     && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Install Chrome.
# RUN apt-get update && apt-get -y install google-chrome-stable

# RUN curl -s https://linux.dropbox.com/packages/ubuntu/dropbox_2020.03.04_amd64.deb -o dropbox_amd64.deb && \
# apt -y install ./dropbox_amd64.deb && rm ./dropbox_amd64.deb

# RUN curl -s https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync-xUbuntu_18.04_amd64.deb -o megacmd-xUbuntu_amd64.deb && \
# apt -y install ./megacmd-xUbuntu_amd64.deb && rm ./megacmd-xUbuntu_amd64.deb

RUN apt-get clean
RUN apt-get autoclean

RUN echo 'pref("browser.tabs.remote.autostart", false);' >> /usr/lib/firefox/browser/defaults/preferences/vendor-firefox.js
RUN rm -rf /var/lib/apt/lists/*

EXPOSE 4000

VOLUME [ "/home/nomachine" ]

ADD nxserver.sh /

RUN chmod +x /nxserver.sh

ENTRYPOINT ["/nxserver.sh"]
