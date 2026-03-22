output "pg_ip" {
  value = hcloud_server.pg.ipv4_address
}

output "pg_client_ip" {
  value = hcloud_server.pg-client.ipv4_address
}

output "k3s_master_ip" {
  value = hcloud_server.k3s-master.ipv4_address
}

output "k3s_worker_ip" {
  value = hcloud_server.k3s-worker.ipv4_address
}
