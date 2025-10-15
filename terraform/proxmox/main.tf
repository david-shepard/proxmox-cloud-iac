terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc04"
    }
  }
  required_version = ">= 0.14"
}

variable "pm_api_url" {
  type = map(any)
  default = {
    pm_api_url      = "https://pveprox.local:8006/api2/json"
    pm_tls_insecure = true
  }
}
variable "pm_api_token_id" {
  type = string
}
variable "pm_api_token_secret" {
  type = string
} 
provider "proxmox" {
  pm_api_url      = var.pm_api_url["pm_api_url"]
  pm_tls_insecure = var.pm_api_url["pm_tls_insecure"] # By default Proxmox Virtual Environment uses self-signed certificates.
  pm_api_token_id = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
  # debug params
#   pm_log_enable = true
#   pm_log_file = "terraform-plugin-proxmox.log"
#   pm_debug = true
#   pm_log_levels = {
#     _default = "debug"
#     _capturelog = ""
#  }
}
