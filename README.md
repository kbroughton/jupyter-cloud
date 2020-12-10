# jupyter-cloud

This is a simple addition to the jupyter/scipy-notebook making it cloud friendly.
* Add support for cloud providers to jupyter notebooks (aws, gcloud, az variants) plus common tools for cloud analytics.
* Adds docker-compose.yml to mount in notebooks to work/templates

It is designed to be run from a docker-compose.yml which includes many other cloud tools.
Data from each tool should be mounted into the jupyter notebook by adding a line like

```
version: '3'
services:
  tool:
    image: mytool
    volumes:
     - ${PWD}/tool/account-data:/data
  jupyter:
    image: jupyter-cloud
    volumes:
     - ${PWD}/tool/account-data:/work/tool/account-data
     - ${PWD}/jupyter-cloud/work:/work
```

The dockerfile comes with useful notebooks in work/templates. To add new ones in a docker-compose run, 
create jupyter-cloud/work/templates and add the files there. Then in the jupyter notebook, copy
the file from work/templates/ to work/.

## Getting Started

```
git clone https://github.com/kbroughton/jupyter-cloud.git
cd jupyter-cloud && docker build -t jupyter-cloud .
```

Move the docker-compose.yml to a location where the data exists (possibly pasting the `jupyter` block from the
docker-compose.yml file into an existing one for data collection.
```
docker-compose up -d jupyter
docker-compose logs jupyter
```
Browse to localhost:8888 and use the token from the output of the logs.

## TODO

* split to dev.Dockerfile, prod.Dockerfile with hardenings and slim packaging for the latter

