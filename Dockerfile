FROM python:3.8-slim

WORKDIR /app
COPY Pipfile* ./

ENV build_deps=build-essential \
    run_deps=git

RUN apt-get update && \
    apt-get install -y --no-install-recommends $build_deps $run_deps &&\
    pip install pipenv==2018.11.26 &&\
    pipenv install --system &&\
    apt-get purge $build_deps -y --auto-remove &&\
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

COPY entrypoint.sh ./

ENTRYPOINT ["/app/entrypoint.sh"]
