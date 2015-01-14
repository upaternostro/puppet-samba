# samba

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with samba](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)
    * [Tests](#running-tests)

##Overview

The Samba module installs, configures, and manages Samba

##Module Description

The Samba module manages the install and configuration of samba, and follows the manual
pages for samba as close as possible.  The module aims to be feature complete in regard
to the manuals.

##Setup

##Usage

Basic usage.  Installs the samba client:

```puppet
class { 'samba::client': }
```

To manage the samba server:

```puppet
class { 'samba::server': }
```

To manage the firewall for samba:

```puppet
class { 'samba::server':
  manage_firewall => true,
}
```

To manage the winbind server:

```puppet
class { 'samba::winbind': }
```

To manage a samba share, use the share defined type:

```puppet
samba::server::share { 'test':
  share_name     => 'test',
  share_comment  => 'MODULES SHOULD GO TO FORGE',
  share_path     => '/vagrant',
  share_guest_ok => 'yes',
}
```

Note:  There are some options that work well with others, please see the
man pages for complete info.

##Reference

###Classes

###Public Classes:

* samba::client
* samba::server
* samba::server::install
* samba::server::config
* samba::server::service
* samba::winbind::install
* samba::winbind::config
* samba::winbind::service

###Private Classes:

* samba::params
* samba::server::firewall

##Limitations

This module has been built on and tested against Puppet 3.0 and higher.

The module has been tested on:

* CentOS 5
* CentOS 6
* Ubuntu 12.04
* Ubuntu 14.04

LDAP configuration has not been added to this module.  Look for future releases for support.

##Development

Please submit bugs in the form of pull requests.

###Running Tests

```
gem install bundler
bundle install
bundle exec rake spec
bundle exec rspec spec/acceptance
```

##Release Notes/Contributors/Etc

0.1.0

* Initial release

0.1.1

* Bug fixes
* Parameter validation for winbind

0.2.0

* Restructure of module layout
* Added firewall support

0.3.0

* Bug fixes
* Parameter cleanup
* Switch to metadata.json
* Add acceptance testing
