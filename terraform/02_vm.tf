data "hcloud_ssh_key" "ssh_key" {
  fingerprint = "06:4b:2b:61:8d:60:f5:f1:28:a2:e5:d1:49:25:54:21"
}

resource "hcloud_server" "pg" {
  name        = "tf-pg"
  server_type = "ccx33"
  image       = "ubuntu-24.04"
  location    = "nbg1"
  ssh_keys    = [data.hcloud_ssh_key.ssh_key.id]
}

resource "hcloud_server" "pg-client" {
  name        = "tf-pg-client"
  server_type = "ccx33"
  image       = "ubuntu-24.04"
  location    = "nbg1"
  ssh_keys    = [data.hcloud_ssh_key.ssh_key.id]
}

resource "hcloud_server" "k3s-master" {
  name        = "tf-k3s-master"
  server_type = "cpx32"
  image       = "ubuntu-24.04"
  location    = "nbg1"
  ssh_keys    = [data.hcloud_ssh_key.ssh_key.id]
}

resource "hcloud_server" "k3s-worker" {
  name        = "tf-k3s-worker"
  server_type = "ccx33"
  image       = "ubuntu-24.04"
  location    = "nbg1"
  ssh_keys    = [data.hcloud_ssh_key.ssh_key.id]
}
