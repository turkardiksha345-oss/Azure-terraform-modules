# Azure Infrastructure as Code with Terraform

Complete Terraform configuration for deploying Azure infrastructure with reusable modules.

## 📁 Project Structure

```
Azure-code/
├── modules/
│   ├── aks/                 # Azure Kubernetes Service module
|   ├── acr/ 
|   ├──
|   ├── azure-sql/                
│   ├── vm/                  # Virtual Machine module
│   ├── network/             # Virtual Network, Subnets, and NSG module
│   └── storage/             # Storage Account module
├── provider.tf              # Azure provider configuration
├── main.tf                  # Root module orchestration
├── variables.tf             # Input variables
├── outputs.tf               # Output values
├── terraform.tfvars.example # Example variables file
└── README.md                # This file
```

## 🚀 Quick Start

### 1. Prerequisites
```bash
terraform --version  # >= 1.0
az login            # Azure CLI authentication
```

### 2. Prepare Variables
```bash
# Copy example file
cp terraform.tfvars.example terraform.tfvars

# Edit with your values
# - Add subscription_id: az account show --query id -o tsv
# - Add tenant_id: az account show --query tenantId -o tsv
# - Generate SSH key: ssh-keygen -t rsa -b 4096
# - Make storage_account_name unique
```

### 3. Deploy
```bash
terraform init
terraform plan
terraform apply
```

## 📦 Modules

### Network Module
- Virtual Network (10.0.0.0/16)
- AKS Subnet (10.0.1.0/24)
- VM Subnet (10.0.2.0/24)
- Network Security Groups

### Storage Module
- Storage Account with GRS replication
- Containers: data, backups, logs
- HTTPS-only access, TLS 1.2 minimum

### VM Module
- Ubuntu 20.04 LTS Virtual Machine
- SSH key-based authentication
- Public IP (optional)

### AKS Module
- Kubernetes Cluster (v1.27)
- Default node pool (3 nodes, autoscaling 1-5)
- Workload node pool (2 nodes)
- RBAC enabled, Azure CNI networking

## 🔧 Common Commands

```bash
terraform init
terraform plan
terraform apply
terraform destroy
terraform validate
terraform fmt -recursive
terraform output
```

## 🔑 Generate SSH Key

```bash
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
cat ~/.ssh/id_rsa.pub
```

## 🎯 Access Resources

### Connect to AKS
```bash
az aks get-credentials \
  --resource-group $(terraform output -raw resource_group_name) \
  --name $(terraform output -raw aks_cluster_name)

kubectl cluster-info
```

### SSH to VM
```bash
VM_IP=$(terraform output -raw vm_public_ip)
ssh azureuser@$VM_IP
```

## 📝 Required Variables

- `subscription_id` - Azure subscription ID
- `tenant_id` - Azure tenant ID
- `resource_group_name` - Resource group name
- `vnet_name` - Virtual network name
- `storage_account_name` - Storage account name (globally unique, 3-24 chars)
- `vm_name` - Virtual machine name
- `ssh_public_key` - SSH public key content
- `cluster_name` - AKS cluster name

## 🗑️ Cleanup

```bash
terraform destroy
```

## 📚 Module Documentation

Each module has its own README.md:
- [Network Module](modules/network/README.md)
- [Storage Module](modules/storage/README.md)
- [VM Module](modules/vm/README.md)
- [AKS Module](modules/aks/README.md)

## ⚠️ Common Issues

| Issue | Solution |
|-------|----------|
| Storage name taken | Add unique suffix |
| SSH key format error | Key must start with `ssh-rsa` |
| Subscription not found | Run `az login` |
| Permission denied | Need Contributor role |

## 💡 Tips

- Always run `terraform plan` before `terraform apply`
- Use `terraform validate` to check syntax
- Keep `terraform.tfvars` secure (add to .gitignore)
