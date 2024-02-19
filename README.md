# Homelab: Ansible Playbook for Common Services

[![Build status](https://img.shields.io/github/actions/workflow/status/muhlba91/homelab-ansible-common-services/pipeline.yml?style=for-the-badge)](https://github.com/muhlba91/homelab-ansible-common-services/actions/workflows/pipeline.yml)
[![License](https://img.shields.io/github/license/muhlba91/homelab-ansible-common-services?style=for-the-badge)](LICENSE.md)

This repository contains the Ansible playbook for common server services deployed throughout the fleet.

---

## Running the Playbook

A valid `inventory.yml` file needs to be generated/supplied containing all server hosts, and settings, like UFW rules.

You can then run the playbook similar to:

```bash
ansible-playbook -i inventory/inventory.yml --extra-vars ansible_ssh_private_key_file=inventory/ssh.key site.yml
```

---

## Roles

### Loopback

Installs `loopback` interfaces with provided additional IP addresses.

Example configuration:

```yaml
loopback_interfaces:
  - ipv4: 10.0.0.1
    ipv6: fe80::1
```

### Packages

Install common packages. Please refer to `packages_list` in the [`defaults/main.yml`](roles/packages/defaults/main.yml) file for all packages installed.

You can disable setting up the ***Debian*** (!!!) backports repository by setting `packages_backports_enabled`.

### UFW

Installs and configures UFW and provided rules.

A set of default rules are installed. Please refer to `ufw_default_rules` in the [`defaults/main.yml`](roles/ufw/defaults/main.yml) file.

This role can be enabled or disabled by setting `ufw_enabled`.

Example configuration:

```yaml
ufw_enabled: true
ufw_rules:
  - comment: port
    port: "8080"
    proto: tcp
    rule: allow
```

### ulimit

Sets the ulimits for open files. This is necessary especially for Kubernetes hosts!

Example configuration:

```yaml
ulimit_open_files: 1048576
```

### Wireguard

Installs `wireguard` on the server.

This role can be enabled or disabled by setting `wireguard_enabled`.

---

## Triggering a Deploy

A deploy ca be triggered by dispatching the [`deploy.yml`](.github/workflows/deploy.yml) workflow.

### Inputs

- `s3_asset_bucket`: S3 Bucket and Path to the inventory to be downloaded and used

### Example Trigger using GitHub Actions

```yaml
- name: Deploy Services
  uses: benc-uk/workflow-dispatch@v1
  with:
    workflow: deploy.yml
    repo: muhlba91/homelab-ansible-common-services
    inputs: '{ "s3_asset_bucket": "bucket/path" }'
    token: ${{ secrets.GITHUB_PAT_TOKEN }}
```

---

## Continuous Integration and Automations

- [GitHub Actions](https://docs.github.com/en/actions) are linting the playbook and roles.
- [Renovate Bot](https://github.com/renovatebot/renovate) is updating Ansible and Python dependencies, and GitHub Actions.
