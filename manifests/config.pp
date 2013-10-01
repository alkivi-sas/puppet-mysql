class mysql::config () {

  File {
    ensure => present,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  file { '/etc/mysql/my.cnf':
    content => template('mysql/my.cnf.erb'),
    notify  => Class['mysql::service'],
  }

  file { '/root/alkivi-scripts/mysql-do':
    source  => 'puppet:///modules/mysql/mysql-do',
    mode    => '0700',
    require => File['/root/alkivi-scripts/'],
  }

  file { '/usr/bin/mysql-do':
    ensure  => link,
    target  => '/root/alkivi-scripts/mysql-do',
    require => File['/root/alkivi-scripts/mysql-do'],
  }

  file { '/root/alkivi-scripts/mysql-add-user':
    source  => 'puppet:///modules/mysql/mysql-add-user',
    mode    => '0700',
    require => File['/root/alkivi-scripts/'],
  }

  file { '/usr/bin/mysql-add-user':
    ensure  => link,
    target  => '/root/alkivi-scripts/mysql-add-user',
    require => File['/root/alkivi-scripts/mysql-add-user'],
  }

  file { '/root/alkivi-scripts/mysql-add-db':
    source  => 'puppet:///modules/mysql/mysql-add-db',
    mode    => '0700',
    require => File['/root/alkivi-scripts/'],
  }

  file { '/usr/bin/mysql-add-db':
    ensure  => link,
    target  => '/root/alkivi-scripts/mysql-add-db',
    require => File['/root/alkivi-scripts/mysql-add-db'],
  }
}

