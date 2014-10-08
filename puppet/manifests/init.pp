$as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$home         = '/home/vagrant'

# --- Preinstall Stage ---------------------------------------------------------

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { 'apt-get -y update':
    unless => "test -e ${home}/.rvm"
  }
}
class { 'apt_get_update':
  stage => preinstall
}

# --- Packages -----------------------------------------------------------------

package { [
    'libpq-dev',
    'libmagickwand-dev', #needed for rmagick gem
    'curl',
    'git-core',
  ]:
  ensure => installed
}

# --- Phantomjs ----------------------------------------------------------------

class {"phantomjs":}

# --- Postgres -----------------------------------------------------------------

class { 'postgresql::server':
  ip_mask_deny_postgres_user => '0.0.0.0/32',
  ip_mask_allow_all_users    => '0.0.0.0/0',
  listen_addresses           => '*',
  postgres_password          => 'postgres',
}->
postgresql::server::role { 'vagrant':
  createdb       => true,
  login          => true,
  password_hash  => postgresql_password("vagrant", "vagrant")
}

# --- Ruby ---------------------------------------------------------------------

include rvm
rvm::system_user { vagrant: }

rvm_system_ruby {
  'ruby-2.0.0-p247':
    ensure => present,
    default_use => true
}
