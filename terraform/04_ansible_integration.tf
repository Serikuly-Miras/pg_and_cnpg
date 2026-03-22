resource "local_file" "ansible_inventory" {
  content = join("\n", concat(
    ["[pg_vm]"],
    [
      "${hcloud_server.pg.name} ansible_host=${hcloud_server.pg.ipv4_address}"
    ],
    [""],
    ["[k3s_master]"],
    [
      "${hcloud_server.k3s-master.name} ansible_host=${hcloud_server.k3s-master.ipv4_address}",
    ],
    [""],
    ["[k3s_worker]"],
    [
      "${hcloud_server.k3s-worker.name} ansible_host=${hcloud_server.k3s-worker.ipv4_address}"
    ],
    [""],
    ["[pgbench_vm]"],
    [
      "${hcloud_server.pg-client.name} ansible_host=${hcloud_server.pg-client.ipv4_address}"
    ],
    [""],
    ["[all:vars]"],
    ["ansible_user=root"],
    ["ansible_ssh_private_key_file=${var.ssh_private_key_path}"],
    ["ansible_ssh_common_args='-o StrictHostKeyChecking=no'"],
    ["ansible_python_interpreter=/usr/bin/python3"]
  ))
  filename = "${path.module}/../ansible/inventory/hosts.ini"
}

