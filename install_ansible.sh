#!/usr/bin/bash

git clone -b terraform https://muralialakuntla3-admin@bitbucket.org/muralialakuntla3/lms-app.git /home/ubuntu
cd lms-app
ansible-playbook lmsweb.yml -i aws.ini
ansible-playbook lmsapi.yml -i aws.ini