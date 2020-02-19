FROM python:3.8-slim

WORKDIR /app
COPY Pipfile* ./

ENV build_deps="build-essential apt-transport-https ca-certificates curl gnupg2 software-properties-common" \
    run_deps="docker-ce-cli git nodejs"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update &&\
    apt-get install -y --no-install-recommends $build_deps &&\
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - &&\
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" &&\
    apt-get update &&\
    apt-get install -y --no-install-recommends $run_deps &&\
    pip install pipenv==2018.11.26 &&\
    pipenv install --system &&\
    apt-get purge $build_deps -y --auto-remove &&\
    apt-get autoremove &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /tmp/*

COPY entrypoint.sh ./

ENTRYPOINT ["/app/entrypoint.sh"]
