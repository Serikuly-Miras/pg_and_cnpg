# PostgreSQL 18 vs CNPG Cluster Benchmarks

## Preamble

Repo containing Terraform and Ansible code for setting up VMs and running benchmarks on Hetzner Cloud.

Heavily skewed and probably unrepresentative performance benchmarks comparing single node PostgreSQL 18 VS single instance CNPG cluster.
CNPG is on top of a k3s cluster with longhorn csi storage adapter.

## Architecture

```
ccx33 / Ubuntu 24.04.4 LTS (Dedicated VM) / Postgresql 18
    ├── 8 vCPU
    ├── 32GB RAM
    └── 240GB SSD Disk

ccx33 / Ubuntu 24.04.4 LTS (Dedicated VM) / Pgbench Client
    ├── 8 vCPU
    ├── 32GB RAM
    └── 240GB SSD Disk

ccx33 / Ubuntu 24.04.4 LTS (Dedicated VM) / k3s Worker Node
    ├── 8 vCPU
    ├── 32GB RAM
    └── 240GB SSD Disk

cpx32 / Ubuntu 24.04.4 LTS (Shared VM) / k3s Master Node
    ├── 4 vCPU
    ├── 8GB RAM
    └── 160GB SSD Disk
```

## Results

The results are not very surprising, but they are interesting to see how much overhead Kubernetes and CNPG add on top of the raw performance of PostgreSQL.

| Benchmark                              | PostgreSQL 18 (Dedicated VM) | CNPG Cluster (k3s) | CNPG relative perfomance |
| -------------------------------------- | ---------------------------- | ------------------ | ------------------------ |
| Read-Only pgbench TPS                  | 41101.864478                 | 8562.530432        | 20,83%                   |
| Read-Write pgbench TPC-B (sort of) TPS | 8114.858496                  | 2671.181028        | 32,91%                   |

## Notes

Both dbs where tuned with the same settings from pg_tuner https://pgtune.leopard.in.ua/ and the same pgbench parameters were used for both benchmarks.

## Usage

```
# 1. Deploy infrastructure
cd terraform && terraform init && terraform apply

# 2. Configure and benchmark
cd ../ansible
ansible-playbook playbooks/0_preflight.yaml
ansible-playbook playbooks/1_init.yaml
ansible-playbook playbooks/2_install_pg.yaml
ansible-playbook playbooks/3_install_cnpg.yaml
ansible-playbook playbooks/4_bench.yaml

# 3. Destroy infrastructure
cd ../terraform && terraform destroy
```
