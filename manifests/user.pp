define mysql::user (
  $domain   = 'localhost',
  $password = true,
) {

  validate_string($domain)

  if($password)
  {

    alkivi_base::passwd { $title:
      type   => 'db',
    }

    exec { "create-mysql_user-${title}":
      command  => "PASSWORD=`cat /root/.passwd/db/${title}` && mysql -e \"CREATE USER ${title}@${domain} IDENTIFIED BY '\$PASSWORD'\" -uroot -p`cat /root/.passwd/db/mysql`",
      provider => 'shell',
      path     => ['/bin', '/sbin', '/usr/bin' ],
      require  => [Class['mysql'], Alkivi_base::Passwd[$title] ],
      unless   => "mysql -u${title} -p`cat /root/.passwd/db/${title}` -e ''",
    }
  }
  else
  {
    exec { "create-mysql_user-${title}":
      command  => "mysql -e \"CREATE USER ${title}@${domain}\" -uroot -p`cat /root/.passwd/db/mysql`",
      provider => 'shell',
      path     => ['/bin', '/sbin', '/usr/bin' ],
      require  => Class['mysql'],
      unless   => "mysql -u${title} -e ''",
    }
  }
}
