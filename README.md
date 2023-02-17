# aws-dind
Based off https://github.com/bentolor/docker-dind-awscli

Adds some extra bits to support AWS CDK and ability to perform assume role within a Gitlab CI pipeline etc

### Apple Silicone Note
If you're trying to build the image Apple silicone (e.g. M1, M2 chip), and update any upstreams, then use this command
```
$ docker buildx build --platform=linux/amd64 . --no-cache --tag martynbutterworth666/aws-dind:latest
```

Then tag a new version (of re-use an existing version tag on the new image if all you've changed is the upstream dependencies)
```
$ docker tag 44dceb32026f martynbutterworth666/aws-dind:1.0.3
```

Use docker desktop to push up to docker hub
