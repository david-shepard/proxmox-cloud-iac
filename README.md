# Proxmox + Cloud IaC

Infrastructure as Code for my hybrid Proxmox homelab and cloud infrastructure using Terraform and Ansible.

## Overview

This repository contains Infrastructure as Code (IaC) for:

- **Local Homelab**: Proxmox Virtual Environment with LXC containers
- **Cloud VPS**: Oracle Cloud infrastructure (free tier)

## Architecture

```
proxmox-cloud-iac/
├── ansible/
│   ├── proxmox/          # Ansible playbooks for Proxmox hosts and containers
│   └── oracle/           # Ansible playbooks for Oracle Cloud (TODO)
└── terraform/
    ├── proxmox/          # Terraform configs for Proxmox LXC provisioning
    └── oracle/           # Terraform configs for Oracle Cloud (TODO)
```

## Proxmox Homelab

### Infrastructure (Terraform)

The Proxmox Terraform configuration manages the following (meager) resources on my homelab.
(TODO: scour ebay for homelab deals)

| Container | VMID | Purpose | Resources |
|-----------|------|---------|-----------|
| Nextcloud | 101 | Cloud storage and collaboration | 1 core, 1GB RAM, 15GB disk |
| K3s Master | 102 | Kubernetes cluster | 2 cores, 4GB RAM, 80GB disk |
| OpenWebUI | 100 | AI interface | 2 cores, 4GB RAM, 50GB disk |


### Infrastructure (Oracle)
(TODO: need to update w/ terraform and ansible configs)
Managed @ https://github.com/david-shepard/flux-infra

| VM | CPU | MEM | HD |
|-----------|------|---------|-----------|
| Oracle ARM VPS Instance | 4 VCPU | 25GB RAM | 200GB disk |



#### Prerequisites

- Proxmox VE 7.0+
- Terraform >= 0.14
- API token with appropriate permissions

#### Configuration

1. Navigate to the Proxmox Terraform directory:
   ```bash
   cd terraform/proxmox
   ```

2. Create a `terraform.tfvars` file with your credentials:
   ```hcl
   pm_api_token_id     = "user@pam!token_id"
   pm_api_token_secret = "your-secret-token"
   ```

3. Initialize and apply:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

### Configuration Management (Ansible)

Ansible playbooks automate configuration and maintenance tasks for Proxmox hosts and LXC containers.

#### Inventory

The inventory (`ansible/proxmox/hosts.yaml`) defines:
- **proxmox_hosts**: Proxmox VM's
- **lxc_containers**: Proxmox LXC containers
- **proxmox_managed**: Group for VM's & LXC's combined

#### Available Playbooks

- `backup_etc_dirs.yml`: Synchronizes `/etc` directories from Proxmox hosts to local backups
- `cronjob-per-host-block.yml`: Manages scheduled tasks
- `debug_hosts.yml`: Verifies connectivity and configuration

#### Usage

```bash
cd ansible/proxmox

# Test connectivity
ansible all -i hosts.yaml -m ping

# Run backup playbook
ansible-playbook -i hosts.yaml backup_etc_dirs.yml

# Run specific playbook with verbose output
ansible-playbook -i hosts.yaml <playbook>.yml -v
```

## Prerequisites

### Tools Required

- [Terraform](https://www.terraform.io/downloads) >= 0.14
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) >= 2.9
- SSH access to Proxmox hosts and containers

### Authentication

#### Proxmox

Generate an API token in the Proxmox web interface:
1. Navigate to Datacenter → Permissions → API Tokens
2. Create a new token with appropriate privileges
3. Store credentials in `terraform/proxmox/terraform.tfvars` or environment variables

#### SSH Keys

Ensure your SSH private key is configured at `~/.ssh/proxmox`:
```bash
chmod 600 ~/.ssh/proxmox
```

## Security Considerations

- **Never commit secrets**: Use `.gitignore` to exclude credential files
- **Terraform state**: Contains sensitive data; store securely (consider remote backends)
- **SSH keys**: Use dedicated keys with appropriate permissions
- **API tokens**: Rotate regularly and use minimal required privileges

## Project Structure

```
.
├── README.md
├── ansible/
│   ├── oracle/
│   │   └── .gitkeep
│   └── proxmox/
│       ├── ansible.cfg
│       ├── backup_etc_dirs.yml
│       ├── backups/
│       ├── cronjob-healtchecks.yml
│       ├── debug_hosts.yml
│       ├── files/
│       ├── host_vars/
│       ├── hosts.yaml
│       └── README.md
└── terraform/
    ├── oracle/
    │   └── .gitkeep
    └── proxmox/
        ├── creds.env
        ├── lxc.tf
        ├── main.tf
        └── terraform.tfvars
```
## Next steps
- [ ] Add configuration for Oracle VPS
- [ ] Refactor ansible directories to follow best practices [(Ansible Community Documentation)](https://docs.ansible.com/ansible/latest/tips_tricks/sample_setup.html)
- [ ] Add VM Proxmox configuration
- [ ] Refactor module(s) out of terraform configuration
- [ ] Integrate with my other repos [david-shepard/flux-infra](https://github.com/david-shepard/flux-infra) and [david-shepard/proxmox-k3s](https://github.com/david-shepard/proxmox-k3s)
