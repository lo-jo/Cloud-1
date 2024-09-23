# Cloud-1
Deployment of a LEMP stack automated with Ansible and hosted on AWS.
The goal is to automate the creation, configuration and deployment of a Wordpress site and the necessary docker infrastructure on an instance provided by a cloud provider.

The project was done in collaboration with [@Chelo](https://github.com/mariav7).

# Usage
``` ansible-playbook main.yaml ``` to create, configure and launch instance

Reach the website at the public ip address provided by your AWS Instance.

# Requirements
Run  ``` . ./install_ansible.sh```  to install ansible

Create a env-inception.yml file located at group_vars/all with the following:
```
BDD_NAME: ""
BDD_USER: "l"
BDD_USER_PASSWORD: ""
BDD_ROOT_PASSWORD: ""
BDD_HOST: "mariadb:3306"
DOMAIN_NAME: ""
WP_TITLE: ""
WP_PATH_DIR: "/var/www/html"
WP_ADMIN_USER: ""
WP_ADMIN_PASSWORD: ""
WP_ADMIN_EMAIL: ""
WP_USER: ""
WP_USER_EMAIL: ""
WP_USER_PASSWORD: ""
WP_USER_ROLE: "admin"
```

Create a env.yml file in the same location with the following:
```
# AWS Credentials
aws_creds:
  ec2_access_key: ""
  ec2_secret_key: ""
```

Create Ansible vault with password file in the root directory
```
# Create a hashed password file
openssl rand -base64 2048 > vault.pass

# Create an ansible vault
ansible-vault create group_vars/all/env.yml --vault-password-file vault.pass
```

Encrypt file with ansible vault
```
# Example:
ansible-vault encrypt group_vars/all/.env    

```

