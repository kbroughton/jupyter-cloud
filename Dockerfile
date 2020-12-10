FROM jupyter/scipy-notebook

USER root
RUN apt update && apt -y install \
    jq \
    nano \
    vim \
    curl

RUN pip install awscli --upgrade && \
    pip install jmespath pyyaml

RUN complete -C `which aws_completer` aws

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y
      

#RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
#RUN apt-get install apt-transport-https ca-certificates gnupg
#RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
#RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
#RUN apt-get update && sudo apt-get install google-cloud-sdk
