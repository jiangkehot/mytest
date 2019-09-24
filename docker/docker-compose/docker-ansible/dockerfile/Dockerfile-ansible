# Latest version of python3
FROM python:latest
RUN pip install -U pip
# RUN pip install ansible
ADD . /root/docker-ansible
RUN pip install -r /root/docker-ansible/requirements.txt
