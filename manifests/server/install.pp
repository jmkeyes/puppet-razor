# == Class: razor::server::install

class razor::server::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} from ${caller_module_name}")
  }

  $package_name   = pick($::razor::server::package_name, 'razor-server')
  $package_ensure = pick($::razor::server::package_ensure, 'installed')

  validate_string($package_name)

  validate_string($package_ensure)
  validate_re($package_ensure, '^(present|latest|installed|[._0-9a-zA-Z:-]+)$')

  package { $package_name:
    ensure => $package_ensure,
  }

  staging::file { 'microkernel.tar':
    source => 'http://links.puppetlabs.com/razor-microkernel-latest.tar',
  }
}
