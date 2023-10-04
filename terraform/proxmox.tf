terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
    pm_api_url = "https://proxmox-server01.example.com:8006/api2/json"

  # Configuration options
}