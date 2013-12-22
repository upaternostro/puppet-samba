#samba

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with samba](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with samba](#beginning-with-[Modulename])
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

The Samba module installs, configures, and manages Samba

##Module Description

If applicable, this section should have a brief description of the technology the module integrates with and what that integration enables. This section should answer the questions: "What does this module *do*?" and "Why would I use it?"

If your module has a range of functionality (installation, configuration, management, etc.) this is the time to mention it.

##Setup

###Beginning with samba	

The very basic steps needed for a user to get the module up and running. 


##Usage

To manage the samba server:

```puppet
class { 'samba':
  manage_server => true,
}
```

To manage a samba share, use the share defined type:

```puppet
samba::share { 'test':
  share_name => 'test',
  share_comment => 'I WANT TO PUT IN FORGE',
  share_path => '/vagrant',
  share_guest_ok => 'yes',
}
```

##Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

##Limitations

This module has been built on and tested against Puppet 3.0 and higher.

The module has been tested on:

*  CentOS 6
*  Ubuntu 12.04

##Development

Please submit bugs in the form of pull requests.

##Release Notes/Contributors/Etc

0.1.0

* Initial release
