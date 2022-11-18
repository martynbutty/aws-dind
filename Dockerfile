FROM docker

WORKDIR /usr/app
COPY ./ /usr/app

ARG GLIBC_VER=2.34-r0

# install glibc compatibility for alpine
RUN apk --update-cache add \
        binutils \
        curl \
        groff \
        bash \
        nodejs-current \
        npm \
        jq \
        gnupg \
    && sed -i 's/ash/bash/g' /etc/passwd \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-i18n-${GLIBC_VER}.apk \
    && apk del libc6-compat \
    && apk add --force-overwrite \
        glibc-${GLIBC_VER}.apk \
        glibc-bin-${GLIBC_VER}.apk \
        glibc-i18n-${GLIBC_VER}.apk \
    && curl -sL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && curl -sL https://github.com/mozilla/sops/releases/download/v3.7.3/sops-v3.7.3.linux -o /usr/local/bin/sops \
    && chmod +x /usr/local/bin/sops \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && apk del --purge glibc-i18n \
    && unzip -q awscliv2.zip \
    && aws/install \
    && rm -rf \
        awscliv2.zip \
        aws \
        /usr/local/aws-cli/v2/*/dist/aws_completer \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples \
    && apk --no-cache del \
        binutils \
        curl \
    && rm glibc-${GLIBC_VER}.apk \
    && rm glibc-bin-${GLIBC_VER}.apk \
    && rm glibc-i18n-${GLIBC_VER}.apk \
    && rm -rf /var/cache/apk/* \
    && docker --version \
    && aws --version \
    && node -v \
    && jq --version \
    && npm install -g --save-dev esbuild@0 \
    && npm i -g aws-cdk 

CMD /bin/bash