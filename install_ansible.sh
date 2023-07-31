#!/usr/bin/bash
ansible-playbook lmsweb.yml -i aws.ini
ansible-playbook lmsapi.yml -i aws.ini