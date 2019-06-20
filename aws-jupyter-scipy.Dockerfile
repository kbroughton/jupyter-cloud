FROM jupyter/scipy-notebook

USER root
RUN apt update && apt -y install \
    jq \
    nano \
    vim 

RUN pip install awscli --upgrade && \
    pip install jmespath pyyaml



