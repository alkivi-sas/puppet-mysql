class mysql::install () {
  package { $mysql::params::mysql_package_name:
    ensure => installed,
  }

  alkivi_base::passwd { 'mysql':
    type    => 'db',
    require => Package[$mysql::params::mysql_package_name],
    before  => Exec['update-mysql-password'],
  }

  exec { 'update-mysql-password':
    command => 'mysqladmin -u root password `cat /root/.passwd/db/mysql`',
    path    => ['/bin', '/sbin', '/usr/bin' ],
    onlyif  => 'mysql -u root -e \'\'',
  }

  # Add a user specific for monitoring, without password
  mysql::user { 'monitoring':
    password => false,
    require  => Exec['update-mysql-password'],
  }

  # Give process grant
  exec { 'grant-process-on-monitoring':
    command  => 'mysql -e \'GRANT PROCESS on *.* to monitoring@localhost; FLUSH PRIVILEGES;\' -uroot -p`cat /root/.passwd/db/mysql`',
    provider => 'shell',
    path     => ['/bin', '/sbin', '/usr/bin' ],
    require  => [Class['mysql'], Mysql::User['monitoring'] ],
    unless   => 'mysql -e \'SHOW GRANTS for monitoring@localhost\' -uroot -p`cat /root/.passwd/db/mysql` | grep -q \'GRANT PROCESS ON *.*\'',
  }

}
