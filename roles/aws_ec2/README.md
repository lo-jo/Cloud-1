AWS_EC2
=========

This Ansible role provisions and configures EC2 instances on AWS. It handles the creation of SSH key pairs, security groups, and EC2 instances.

Requirements
------------
Ansible 2.9 or later
amazon.aws collection installed (ansible-galaxy collection install amazon.aws)
AWS account and appropriate credentials
Ansible Vault to secure sensitive information (optional)
Role Variables


Role Variables
--------------

The following variables are used by the aws_ec2 role:

*Required Variables*
key_name:
Description: The name of the SSH key pair to create or use.
Default: None


key_file_path:
Description: Path to save the private key file.
Default: None

region:
Description: AWS region where the EC2 instance will be provisioned.
Default: eu-west-3

image:
Description: AMI ID for the EC2 instance.
Default: ami-04a92520784b93e73 (Ubuntu 24.04 LTS)

instance_type:
Description: Type of the EC2 instance.
Default: t2.micro

sec_group:
Description: Security group name.
Default: test-group

hosts_ini_file:
Description: Path to the hosts.ini file where the EC2 instance details will be added.
Default: ../hosts.ini

AWS Credentials
AWS credentials should be stored in a separate variables file (e.g., group_vars/all/env.yml), or configured in environment variables:
```
aws_creds:
  ec2_access_key: YOUR_ACCESS_KEY
  ec2_secret_key: YOUR_SECRET_KEY
```

Dependencies
------------

This role depends on the amazon.aws collection. Install it with the following command:
```
ansible-galaxy collection install amazon.aws

```

Example Playbook
----------------

```
---
- name: Provision EC2 Instance on AWS
  hosts: localhost
  gather_facts: false

  roles:
    - aws_ec2
```
