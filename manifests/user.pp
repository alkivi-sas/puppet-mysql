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

    $mysql_password = alkivi_password('mysql', 'db')
    $user_password = alkivi_password($title, 'db')


    exec { "create-mysql_user-${title}":
      command  => "mysql -e \"CREATE USER ${title}@${domain} IDENTIFIED BY '${user_password}'\" -uroot -p${mysql_password}",
      provider => 'shell',
      path     => ['/bin', '/sbin', '/usr/bin' ],
      require  => [Class['mysql'], Alkivi_base::Passwd[$title] ],
      unless   => "mysql -u${title} -p${user_password} -e ''",
    }
  }
  else
  {
    exec { "create-mysql_user-${title}":
      command  => "mysql -e \"CREATE USER ${title}@${domain}\" -uroot -p${mysql_password}",
      provider => 'shell',
      path     => ['/bin', '/sbin', '/usr/bin' ],
      require  => Class['mysql'],
      unless   => "mysql -u${title} -e ''",
    }
  }
}
