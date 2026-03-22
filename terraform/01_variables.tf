variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key for Ansible"
  type        = string
  sensitive   = true
}
