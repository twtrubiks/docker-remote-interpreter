FROM python:3.6.4
LABEL maintainer twtrubiks
ENV PYTHONUNBUFFERED 1
RUN mkdir /docker_remote_interpreter
WORKDIR /docker_remote_interpreter
COPY . /docker_remote_interpreter/
RUN pip install -r requirements.txt