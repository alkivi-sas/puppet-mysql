# MySQL Module

This module will install and configure a MySQL server and allow you to create/manage database and users.

## Usage

### Minimal server configuration

```puppet
class { 'mysql': }
```
This will do the typical install, configure and service management. 
By default a monitoring user with 'GRANT PROCESS' will be created.
Admin password for mysql will be automatically created in /root/.passwd/db/mysql (need alkivi_base module)

### More server configuration

```puppet
class { 'mysql':
  port                   => '3306',
  socket                 => '/var/run/mysqld/mysqld.sock',
  bind_address           => '127.0.0.1',
  default_storage_engine => 'INNODB',
  default_table_type     => 'innodb',
  motd                   => true,
}
```


### User configuration

```puppet
mysql::user{ 'monitoring':
  password => false,
}
```
if password = true, then password is stored in /root/.passwd/db/name

### DB configuration

```puppet
mysql::database{ 'zabbix':
  user    => 'zabbix',
  require => Class['mysql'],
}
```
if user is specifyed, user will be created and granted with access on database.*


## Credits

Backup is base on [AutoMySQLBackup](http://sourceforge.net/projects/automysqlbackup/) specific license apply for this file.

## Limitations

* This module has been tested on Debian Wheezy, Squeeze.

## License

The code is freely distributable under the terms of the LGPLv3 license.

## Contact

Need help ? contact@alkivi.fr

## Support

Please log tickets and issues at our [Github](https://github.com/alkivi-sas/)
