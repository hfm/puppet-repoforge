# puppet-repoforge

[![Build Status](https://img.shields.io/travis/hfm/puppet-repoforge/master.svg?style=flat-square)](https://travis-ci.org/hfm/puppet-repoforge)
[![Puppet Forge](https://img.shields.io/puppetforge/v/hfm/repoforge.svg?style=flat-square)](https://forge.puppetlabs.com/hfm/repoforge)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with repoforge](#setup)
    * [Beginning with repoforge](#beginning-with-repoforge)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module configure [repoforge's RPM repository](http://rpms.famillecollet.com/) and import RPM-GPG-KEY-rpmforge-dag and RPM-GPG-KEY-rpmforge-fabian.

## Setup

### Beginning with repoforge

To configure the repoforge with default parameters, declare the `repoforge` class.

```puppet
include repoforge
```

## Usage

### Configuring repoforge

```puppet
class { 'repoforge':
  rpmforge_enabled        => 1,
  rpmforge_extras_enabled => 1,
}
```

### Configuring modules from Hiera

```yaml
---
repoforge::rpmforge_enabled: 1
repoforge::rpmforge_extras_enabled: 1
```

## Reference

### Classes

#### Public Classes

- [`repoforge`](#repoforge):  Configure the repoforge repository and import the GPG keys.

### Defined Types

- `repoforge::rpm_gpg_key`: Import the RPM GPG key.

## Limitations

This module has been tested on:

- RedHat Enterprise Linux 5, 6, 7
- CentOS 5, 6, 7
- Scientific Linux 5, 6, 7

## Development

### Running tests

The STNS puppet module contains tests for both [rspec-puppet](http://rspec-puppet.com/) (unit tests) and [beaker-rspec](https://github.com/puppetlabs/beaker-rspec) (acceptance tests) to verify functionality. For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart

- Unit tests:

```console
$ bundle install
$ bundle exec rake lint
$ bundle exec rake validate
$ bundle exec rake spec
```

- Acceptance tests:

```console
# Set your DOCKER_HOST variable
$ eval "$(docker-machine env default)"

# Run beaker acceptance tests
$ BEAKER_set=centos7 bundle exec rake beaker
```
