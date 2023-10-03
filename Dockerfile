FROM jupyter/scipy-notebook:notebook-6.4.12

USER root
RUN apt update && apt -y install \
    jq \
    nano \
    curl 

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

RUN complete -C `which aws_completer` aws

RUN apt-get install -y apt-transport-https ca-certificates gnupg
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 40976EAF437D05B5 8B57C5C2836F4BEB
#RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"      
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN curl -sL https://istio.io/downloadIstioctl | sh -
RUN export PATH=$PATH:$HOME/.istioctl/bin
RUN echo '[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"' >> ~/.bash_profile

COPY requirements.txt .
RUN pip install -r requirements.txt

RUN conda install -y google-cloud-logging 
RUN conda install -y -c conda-forge google-cloud-storage

RUN jupyter contrib nbextension install

#RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
#RUN apt-get install apt-transport-https ca-certificates gnupg
#RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
#RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
#RUN apt-get update && sudo apt-get install google-cloud-sdk
