class mysql::params () {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $mysql_service_name   = 'mysql'
      $mysql_package_name   = 'mysql-server'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}

