# Cloud-1
Deployment of a LEMP stack automated with Ansible and hosted on AWS


## What is Ansible?
Ansible is a software tool that enables cross-platform automation and orchestration at scale.

Ansible uses the concepts of control and managed nodes. It connects from the control node, any machine with Ansible installed, to the managed nodes sending commands and instructions to them.


## Basic Concepts & Terms
Host: A remote machine managed by Ansible.

Group: Several hosts grouped together that share a common attribute.

Inventory: A collection of all the hosts and groups that Ansible manages. Could be a static file in the simple cases or we can pull the inventory from remote sources, such as cloud providers.

Modules: Units of code that Ansible sends to the remote nodes for execution.

Tasks: Units of action that combine a module and its arguments along with some other parameters.

​​Playbooks: An ordered list of tasks along with its necessary parameters that define a recipe to configure a system.

Roles: Redistributable units of organization that allow users to share automation code easier.

YAML: A popular and simple data format that is very clean and understandable by humans.

## Install Ansible
``` 
python3 -m pip install ansible
sudo apt-get install ansible
```

## Config
hosts - It's an inventory file that contains pieces of information about managed servers by ansible. It allows you to create a group of servers that make you more easier to manage and scale the inventory file itself. The inventory file can be created with many different formats, including the INI and YAML formats.

playbook.yml - The master playbook file that contains which group of hosts that will be managed using our available roles.

roles - it's a group of Ansible playbooks that will be used to provision the server. The ansible roles have their own directory structures, each role will contain directories such as tasks, handlers, vars etc.