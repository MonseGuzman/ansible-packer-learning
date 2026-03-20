# Ansible & Terraform
This is a simple project where I can learn how to configure instances on an ansible project.

Coming soon - Packer files.

### Tools:
[![tools](https://skillicons.dev/icons?i=terraform,ansible&theme=light)](https://skillicons.dev)

## Instructions
1. Export your env variables for the cloud providers:
```
cd terraform

export ARM_CLIENT_ID="<APPID_VALUE>"
export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
export ARM_TENANT_ID="<TENANT_VALUE>"

export AWS_ACCESS_KEY_ID="<ACCESS_KEY_ID>"
export AWS_SECRET_ACCESS_KEY="<SECRET_ACCESS_KEY_VALUE>"
```

2. Deploy the AWS and Azure instances:
```
terraform init
terraform plan
terraform apply --auto-approve
```

3. Run Ansible commands in the root folder:
```
ansible [node_name or group] -m ping -i inventory
ansible-playbook <playbook_name.yml> --syntax-check
ansible-playbook -i <inventory_file> <playbook_name.yml>
```

4. Cleanup
```
cd terraform

terraform plan -destroy
terraform destroy --auto-approve
```

## Project structure
*  Ansible folder:
Install packages to install, configure and start a specific service.

* Terraform folder:
Deploy the nodes (instances) and create the inventory file for ansible.

