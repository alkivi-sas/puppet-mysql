define mysql::database (
  $user,
  $charset = 'utf8',
) {

  validate_string($user)
  validate_string($charset)

  mysql::user { $user: }

  exec { "create-database-${title}":
    command  => "mysql -e 'CREATE DATABASE ${title} character SET utf8; GRANT ALL on ${title}.* to ${user}@localhost; FLUSH PRIVILEGES;' -uroot -p`cat /root/.passwd/db/mysql`",
    provider => 'shell',
    path     => ['/bin', '/sbin', '/usr/bin' ],
    require  => [Class['mysql'], Mysql::User[$user] ],
    unless   => "mysql -e 'SHOW DATABASES LIKE \"${title}\"' -uroot -p`cat /root/.passwd/db/mysql` | grep -q ${title}",
  }
}
