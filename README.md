# puppet-module-gems

This repository contains an abstraction for the management of Gem dependencies for Puppet modules. These gem dependencies are based on a matrix of Ruby version, Gemfile group, and Operating System Family.

Linux-based modules:

| Gemfile group/Ruby_version | ruby-1.8.x | ruby-1.9.x | ruby-2.1.x | ruby-2.3.x |
|:---|:---|:---|:---|:---|
| default | x | x | x | x |
| development | x | x | x | x |
| unit test | x | x | x | x |
| system test | x | x | x | x |

Windows-based modules:

| Gemfile group/Ruby_version | ruby-1.8.x | ruby-1.9.x | ruby-2.1.x | ruby-2.3.x |
|:---|:---|:---|:---|:---|
| default | x | x | x | x |
| development | x | x | x | x |
| unit test | x | x | x | x |
| system test | x | x | x | x |

The gems produced by this matrix will have the naming convention of:
`puppet-module-{group}-{os_family}-{ruby_version}`
