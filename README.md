# samba

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with samba](#setup)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)

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
class { 'samba': }
```

To manage the samba server:

```puppet
class { 'samba':
  server_manage => true,
}
```

To manage the winbind server:

```puppet
class { 'samba':
  server_manage => true,
  winbind_manage => true,
}
```

To manage a samba share, use the share defined type:

```puppet
samba::share { 'test':
  share_name     => 'test',
  share_comment  => 'MODULES SHOULD GO TO FORGE',
  share_path     => '/vagrant',
  share_guest_ok => 'yes',
}
```

Note:  There are some options that work well with others, please see the
man pages for complete info.

##Reference

###Classes:

* samba::init
* samba::share
* samba::client::install
* samba::params
* samba::server::install
* samba::server::config
* samba::server::service
* samba::winbind::install
* samba::winbind::service

##Limitations

This module has been built on and tested against Puppet 3.0 and higher.

The module has been tested on:

*  CentOS 6
*  Ubuntu 12.04

LDAP configuration has not been added to this module.  Look for future releases for support.

##Development

Please submit bugs in the form of pull requests.

##Release Notes/Contributors/Etc

0.1.0

* Initial release

0.1.1

* Bug fixes
* Parameter validation for winbind
