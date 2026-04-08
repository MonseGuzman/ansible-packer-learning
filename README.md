# Ansible & Terraform

## Multi-Cloud Immutable Infrastructure: Packer, Ansible & Terraform

This project demonstrates a complete confuration and deploy "Golden Images" across **AWS** and **Azure**. By combining **Packer** for image creation, **Ansible** for configuration management, and **Terraform** for infrastructure provisioning, this repository implements a modern GitOps workflow for immutable infrastructure.

_Coming soon - Packer files._

## 🛠 Tech Stack

- **Provisioner:** [Ansible](https://www.ansible.com/) (System configuration & hardening).
- **Image Builder:** [Packer](https://www.packer.io/) (Automated VM images for AWS & Azure).
- **IaC:** [Terraform](https://www.terraform.io/) (Infrastructure orchestration).
- **Cloud Providers:** AWS & Microsoft Azure.

[![tools](https://skillicons.dev/icons?i=terraform,ansible&theme=light)](https://skillicons.dev)

## 🪄 Getting Started
1. Build the Images
Navigate to the `packer/` directory and initialize the plugins:

```Bash
packer init .
packer build -var-file="variables.pkr.hcl" aws-ubuntu.pkr.hcl
```

2. Deploy Infrastructure
Once the images are ready, export your env variables for the cloud providers ans use Terraform to deploy:

```Bash
export ARM_CLIENT_ID="<APPID_VALUE>"
export ARM_CLIENT_SECRET="<PASSWORD_VALUE>"
export ARM_SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
export ARM_TENANT_ID="<TENANT_VALUE>"

export AWS_ACCESS_KEY_ID=<ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<SECRET_ACCESS_KEY_VALUE>

cd terraform

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

4. Clean up
```
cd terraform

terraform plan -destroy
terraform destroy --auto-approve
```

## 🧬 System Architecture

The project structure is divided into three main phases:

1.  **Bake (Packer + Ansible):** Packer spins up a temporary instance in the cloud, and Ansible applies playbooks to install dependencies, security patches, and application code.
2.  **Register:** Once the image is baked, it is saved as an **AMI (AWS)** or a **Managed Image (Azure)**.
3.  **Deploy (Terraform):** Terraform fetches the latest image ID dynamically and deploys the production-ready infrastructure (VMs, Networking, Load Balancers).

## 📁 Repository Structure

```text
.
├── packer/
│   ├── ubuntu.pkr.hcl     # Packer template for AWS and Azure
│   └── variables.pkr.hcl      # Shared variables
├── ansible/
│   └── playbooks/             # Main configuration logic
│       └── vars/              # Reusable variables for the playbooks
│        └── all.yaml          # Global variables
└── terraform/
    ├── tempales/              # Template to create inventory file to Ansible.
    ├── aws_instance.tf        # AWS EC2 deployment
    └── azure_vm.tf            # Azure deployment
````
