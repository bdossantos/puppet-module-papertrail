# Puppet Papertrail Module

[![Build Status](https://travis-ci.org/bdossantos/puppet-module-papertrail.png?branch=master)](https://travis-ci.org/bdossantos/puppet-module-papertrail)

Module for configuring [Papertrail](https://papertrailapp.com/) with [Rsyslog](http://rsyslog.com/)

Tested on Debian GNU/Linux 6.0 Squeeze with Puppet 2.6. Patches for other operating systems welcome.

## Installation

Clone this repo to a papertrail directory under your Puppet modules directory :

```bash
git clone git://github.com/Benjamin-Ds/puppet-module-papertrail.git papertrail
```

## Usage

```puppet
node nodename {
  class { 'papertrail':
    port           => 12345,
    optional_files => [
      '/var/log/daemon.log',
      '/var/log/nginx/error.log',
    ]
  }
}
```

Or

```
puppet apply -e "class { 'papertrail': optional_files => ['/var/log/daemon.log', '/var/log/auth.log'], port => 1234 }"
```

## Running the tests

Install the dependencies using [Bundler](http://gembundler.com):

```bash
bundle install
```

Run the following command :

```bash
bundle exec rake spec
```
