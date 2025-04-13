# Ansible Role: ASDF

[![CI](https://github.com/afreisinger/ansible-role-asdf/actions/workflows/ci.yml/badge.svg)](https://github.com/afreisinger/ansible-role-asdf/actions/workflows/ci.yml)

Ansible role for installing [asdf] version manager for the current user.

Don't use this role on production servers as it supports installing asdf only
under user home directory.

[asdf]: https://asdf-vm.com

## Requirements

Ansible 2.9 or higher

## Configuration Variables

Set `asdf_init_shell` to `false` if you're managing your shell rc files using your
own .dotfiles repository, for example.

```yaml
# Configure shell rc files
asdf_init_shell: true
asdf_plugins:
  - name: "terraform"    # a plugin name
    repository: ""       # a plugin repository, optional
    versions:            # a list of the package versions to install
      - "0.11.14"
    global: "0.11.14"    # set as a global version, optional
```

## Version Updates

Run the following scripts to get the latest releases from GitHub and update them in
role defaults.

Update [asdf] release:

```bash
make update
```

## Dependencies

None

## Example Playbook

```yaml
- hosts: localhost
  roles:
    - { role: afreisinger.asdf }
```

## Licensing

MIT / BSD

## Author

Created in 2025 by [Adrian Freisinger](https://afreisinger.gitlab.io/), inspired by [@markosamuli](https://github.com/markosamuli)
