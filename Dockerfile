FROM amazonlinux:2

RUN yum upgrade -y && \
    amazon-linux-extras install epel -y && \
    yum install -y chromium cups-libs dbus-glib libXScrnSaver libXrandr libXcursor libXinerama cairo cairo-gobject pango GConf2 tar git

#install nodejs 12
ENV INSTALL_NODE_VERSION 12.22.4
ENV NVM_DIR /usr/local/nvm
RUN mkdir $NVM_DIR
ENV NODE_VERSION=12.22.4

RUN set -ex \
    && curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && chmod 755 $NVM_DIR/nvm.sh \
    && nvm install $INSTALL_NODE_VERSION \
    && nvm alias default $INSTALL_NODE_VERSION \
    && nvm use default \
    && export NODE_VERSION=$(node --version) \
    && npm install yarn -g

ENV NODE_PATH $NVM_DIR/v$INSTALL_NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR:$NVM_DIR/versions/node/bin:$PATH



COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh


#CMD ["/bin/bash"]
ENTRYPOINT . /entrypoint.sh
