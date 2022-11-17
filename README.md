# aws-dind
Based off https://github.com/bentolor/docker-dind-awscli

Adds some extra bits to support AWS CDK and ability to perform assume role within a Gitlab CI pipeline etc

### Apple Silicone Note
If you're trying to build the image Apple silicone (e.g. M1, M2 chip), then use this command
```
$ docker buildx build --platform=linux/amd64 .
```