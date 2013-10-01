class mysql (
  $port                   = '3306',
  $socket                 = '/var/run/mysqld/mysqld.sock',
  $bind_address           = '127.0.0.1',
  $default_storage_engine = 'INNODB',
  $default_table_type     = 'innodb',
  $motd                   = true,
) {

  if($motd)
  {
    motd::register{'Mysql Server': }
  }

  # declare all parameterized classes
  class { 'mysql::params': }
  class { 'mysql::install': }
  class { 'mysql::config': }
  class { 'mysql::service': }

  # declare relationships
  Class['mysql::params'] ->
  Class['mysql::install'] ->
  Class['mysql::config'] ->
  Class['mysql::service']
}

