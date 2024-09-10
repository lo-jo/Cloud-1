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

## Ansible vault
[Ansible vault](https://docs.ansible.com/ansible/latest/vault_guide/index.html) allows encryption and manages sensitive data such as passwords etc.

For this project, we will encrypte the AWS credentials (Acces keys):
```
# Create a hashed password file in the root directory
openssl rand -base64 2048 > vault.pass

# Create an ansible vault
ansible-vault create group_vars/all/pass.yml --vault-password-file vault.pass
```

To edit the pass.yml file:
```
# Editing 'pass.yml'
ansible-vault edit group_vars/all/pass.yml --vault-password-file vault.pass

# In our case add the AWS credentials
ec2_access_key: <your-access-key>
ec2_secret_key: <your-secret-key>
```

## AWS Set up
- After successfully creating a "free" AWS account, we need to create an access key in order to be able to use the AWS API

### BEST PRACTICES AWS Access Keys
Root user acces keys are not recommended because you can't specify the root user in a permissions policy or limit its permissions.
Alternatively, using a [IAM role](https://docs.aws.amazon.com/IAM/latest/UserGuide/security-creds.html) provides temporary rather than logn-term credentials.

- In the IAM Dashboard, on the left side under *Access management* click on Users, add user and create an access key.

### AWS Key Pairs
In the EC2 Dashboard on the left side, under *Network & Security* click on [Key Pairs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html?icmpid=docs_ec2_console)

These keys pairs (consisting of a public key and a private key) is a set of security credentials used to prove your identity when connecting to an Amazon EC2 instance. In our case, one key allows us to securely SSH into the instance. Amazon EC2 stores the public key on the instance and we save the private key somewhere "safe".

- 1. Create a Key Pair directly from AWS and save the file .pem to able to connect via SSH
    OR
- 2. Create/Use a SSH key locally and called it in a ansible playbook
    ```
    # 1. This creates a public (.pub) and private key in the ~/.ssh/ directory
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/my_aws

    # 2. Ensure private key is not publicly viewable
    chmod 400 ~/.ssh/my_aws
    ```

### Run Playbook
```
# Check if Ansible is installed and PATH is modified
chmod +x ./install_ansible.sh && . ./install_ansible.sh

# Verbose mode flag -vvv
ansible-playbook playbooks/provision_ec2.yml -i hosts.ini --vault-password-file vault.pass -vvv

# SSH connection Example:
ssh -i "~/.ssh/aws_cloud1_keypair.pem" ubuntu@ec2-15-237-181-238.eu-west-3.compute.amazonaws.com
```