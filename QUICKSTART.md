# Quick Start Guide

## 🚀 Get Started in 5 Minutes

### Step 1: Prerequisites Check
```bash
terraform --version  # Should be >= 1.0
az --version        # Azure CLI
```

### Step 2: Authenticate with Azure
```bash
az login
# Select your subscription if needed
az account set --subscription "<subscription-id>"
```

### Step 3: Prepare Variables File
```bash
# Copy dev environment file
cp environments/dev.tfvars terraform.tfvars

# Edit with your values
# - Add subscription_id: az account show --query id -o tsv
# - Add tenant_id: az account show --query tenantId -o tsv
# - Generate SSH key: ssh-keygen -t rsa -b 4096
# - Make storage_account_name unique (e.g., add random numbers)
```

### Step 4: Initialize and Plan
```bash
terraform init
terraform plan -var-file="terraform.tfvars"
```

### Step 5: Deploy Infrastructure
```bash
terraform apply -var-file="terraform.tfvars"
# Type 'yes' when prompted
```

### Step 6: Access Your Resources
```bash
# Get all outputs
terraform output

# Connect to AKS
az aks get-credentials \
  --resource-group $(terraform output -raw resource_group_name) \
  --name $(terraform output -raw aks_cluster_name)

# Test Kubernetes
kubectl get nodes
```

## 📁 Project Structure

```
Azure-code/
│
├── modules/                          # Reusable Terraform modules
│   ├── aks/
│   │   ├── main.tf                  # AKS cluster and node pools
│   │   ├── variables.tf              # Input variables
│   │   └── outputs.tf                # Output values
│   ├── vm/
│   │   ├── main.tf                  # Virtual machine resources
│   │   ├── variables.tf              # Input variables
│   │   └── outputs.tf                # Output values
│   ├── network/
│   │   ├── main.tf                  # VNet, subnets, NSG
│   │   ├── variables.tf              # Input variables
│   │   └── outputs.tf                # Output values
│   └── storage/
│       ├── main.tf                  # Storage account and containers
│       ├── variables.tf              # Input variables
│       └── outputs.tf                # Output values
│
├── environments/                     # Environment configurations
│   ├── dev.tfvars                   # Development variables
│   └── prod.tfvars                  # Production variables
│
├── provider.tf                       # Azure provider configuration
├── main.tf                          # Root module (calls all modules)
├── variables.tf                     # Root variables
├── outputs.tf                       # Root outputs
├── README.md                        # Full documentation
├── DEPLOYMENT_GUIDE.md              # Detailed deployment guide
├── QUICKSTART.md                    # This file
└── .gitignore                       # Git ignore rules
```

## 🔧 Common Commands

```bash
# Initialize Terraform (run once)
terraform init

# Plan changes
terraform plan -var-file="terraform.tfvars"

# Apply configuration
terraform apply -var-file="terraform.tfvars"

# Destroy all resources
terraform destroy -var-file="terraform.tfvars"

# Show state
terraform state list
terraform state show module.aks

# Validate configuration
terraform validate

# Format code
terraform fmt -recursive

# Get specific output
terraform output aks_cluster_name
terraform output -json > outputs.json
```

## 🔑 Generate SSH Key

```bash
# Generate new SSH key pair (if needed)
ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""

# Get public key content
cat ~/.ssh/id_rsa.pub

# Copy the output and paste in terraform.tfvars
```

## 🌍 Azure Authentication

```bash
# Login to Azure
az login

# Show current subscription
az account show

# Get subscription ID
az account show --query id -o tsv

# Get tenant ID
az account show --query tenantId -o tsv

# Switch subscription
az account set --subscription "<subscription-id>"
```

## 💾 Update Variables for Different Environments

### Development
```bash
terraform apply -var-file="environments/dev.tfvars"
```

### Production
```bash
terraform apply -var-file="environments/prod.tfvars"
```

## 🎯 What Gets Created

### Network Module
- Virtual Network (10.0.0.0/16)
- AKS Subnet (10.0.1.0/24)
- VM Subnet (10.0.2.0/24)
- Network Security Group with HTTP/HTTPS/SSH rules

### Storage Module
- Storage Account (Standard/Premium tier)
- 3 Containers: data, backups, logs

### VM Module
- Virtual Machine (Linux - Ubuntu)
- Network Interface
- Public IP Address (optional)
- SSH key-based authentication

### AKS Module
- Kubernetes Cluster (v1.27)
- Default Node Pool (3 nodes, autoscaling 1-5)
- Workload Node Pool (2 nodes)
- Azure CNI networking
- RBAC enabled

## 🚨 Common Issues and Solutions

### Storage Account Name Error
**Problem**: "Storage account name is not unique"
**Solution**: Edit `terraform.tfvars` and add a unique suffix:
```hcl
storage_account_name = "storageuniqueXXXXXX"  # Add numbers/letters
```

### SSH Public Key Error
**Problem**: "Invalid SSH public key format"
**Solution**: Ensure key starts with "ssh-rsa":
```bash
cat ~/.ssh/id_rsa.pub  # Should start with "ssh-rsa"
```

### Subscription ID Not Found
**Problem**: "Invalid subscription_id"
**Solution**: Get correct ID:
```bash
az account show --query id -o tsv
```

### Permission Denied
**Problem**: "Insufficient privileges"
**Solution**: Ensure you have appropriate Azure RBAC roles (Contributor or Owner)

## 📊 Monitoring

```bash
# View resource groups
az group list --output table

# View AKS clusters
az aks list --output table

# View VMs
az vm list --output table

# View storage accounts
az storage account list --output table
```

## 🗑️ Cleanup

```bash
# Destroy specific module
terraform destroy -target=module.vm

# Destroy entire infrastructure
terraform destroy -var-file="terraform.tfvars"

# Type 'yes' when prompted
```

## 📚 Additional Resources

- [Terraform Docs](https://www.terraform.io/docs)
- [Azure Provider Docs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [AKS Documentation](https://docs.microsoft.com/azure/aks/)
- [Azure CLI Reference](https://docs.microsoft.com/cli/azure/reference-index)

## 💡 Tips

1. **Always run `terraform plan` before `apply`** to review changes
2. **Use `-var-file` to manage different environments**
3. **Keep SSH keys secure** - never commit private keys
4. **Use tags** for cost tracking and resource management
5. **Enable remote state** for team collaboration
6. **Review outputs** after deployment for connection strings

## 🤝 Support

For issues or questions:
1. Check error messages carefully
2. Review `terraform.tfvars` for missing/invalid values
3. Verify Azure subscription and permissions
4. Check Azure limits for your subscription
5. Review logs: `terraform logs`

---

**Happy Deploying! 🎉**
