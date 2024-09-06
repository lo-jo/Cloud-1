# AWS

## How to set up the AWS environment
``` 
# Installing AWS CLI
pip install awscli
```

```
# Configuring with credentials
aws configure
```

## Installing dependencies

```
pip install boto3 botocore
```

## Automate with ansible
### THE PLAYBOOK
Ansible AWS official guide : https://docs.ansible.com/ansible/latest/collections/amazon/aws/docsite/guide_aws.html 

- 1. authentication
Authentication with the AWS-related modules is handled by either specifying your access and secret key as ENV variables or module arguments.
