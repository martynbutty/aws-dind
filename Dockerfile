FROM bentolor/docker-dind-awscli

RUN apk --update-cache add \
        nodejs-current \
        npm \
        jq \
    && node -v \
    && jq --version \
    && npm install --save-dev esbuild@0 \
    && npm i -g aws-cdk

CMD /bin/bash