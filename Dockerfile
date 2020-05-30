FROM lordcris/nomachine

RUN apt update
#RUN curl -s https://linux.dropbox.com/packages/ubuntu/dropbox_2020.03.04_amd64.deb -o dropbox_amd64.deb && \
apt -y install ./dropbox_amd64.deb && rm ./dropbox_amd64.deb

#RUN curl -s https://mega.nz/linux/MEGAsync/xUbuntu_18.04/amd64/megasync-xUbuntu_18.04_amd64.deb -o megacmd-xUbuntu_amd64.deb && \
apt -y install ./megacmd-xUbuntu_amd64.deb && rm ./megacmd-xUbuntu_amd64.deb

RUN apt-get clean
RUN apt-get autoclean


EXPOSE 4000

VOLUME [ "/home/nomachine" ]


ENTRYPOINT ["/nxserver.sh"]
