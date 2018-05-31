# dockerfiles-dqm4hep

Docker __context__ to create docker DQM4HEP image to run 
DDAMA (DAMIC DAta Monitoring Analysis) package. The image is based on
the root 6 image build over ubuntu-16.04.

## Install

Assuming `docker` and `docker-compose` is installed on your system (host-computer).

1. Clone the docker dqm4hep repository

```bash
$ git clone https://github.com/ncastello/dockerfiles-dqm4hep
$ cd dockerfiles-dqm4hep
```

2. To get the docker container you can either download the image from the dockerhub
   ```bash
   $ docker pull ncastello/dqm4hep
   ```
   or alternatively build the docker image from the Dockerfile:

   ```bash
   # Using docker
   $ docker build github.com/ncastello/dqm4hep
   # Using docker-compose within the repo directory
   $ docker-compose build dqm4hep
   ```






