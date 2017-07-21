# ptp

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with ptp](#setup)
    * [What ptp affects](#what-ptp-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ptp](#beginning-with-ptp)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

The ptp module installs, configures and manages the ptp4l, phc2sys and
timemaster services across a range of operating systems and distributions.

## Setup

### What ptp affects **OPTIONAL**

* Installs the linuxptp package
* Configure one or more ptp4l & phc2sys instances (depend on configuration)
* Configure timemaster service (depend on configuration)

### Setup Requirements **OPTIONAL**

The linuxptp package can be found in a number of default repositories.
There must be at least one ptp capable NIC installed on system, refer to
"5.3.2" in this [page](http://linuxptp.sourceforge.net/) for a list of cards that support ptp.

### Beginning with ptp

A simple puppet code below is enough to enable & start ptp4l service on
selected ptp capable NIC `eth0`:

```puppet
ptp::instance_ptp4l { 'instance_name':
  ptp4l_interface => 'eth0',
}
```

## Usage

### Install and Enable one ptp instance

```puppet
ptp::instance_ptp4l { 'ptp4l_instance0':
  ptp4l_interface => 'eth0',
}
```

### Install and Enable two ptp instances

```puppet
ptp::instance_ptp4l { 'ptp4l_instance1':
  ptp4l_interface => 'eth1',
}

ptp::instance_ptp4l { 'ptp4l_instance2':
  ptp4l_interface => 'eth2',
}
```

### Configure ptp in slave mode

```puppet
ptp::instance_ptp4l { 'ptp4l_instance3':
  ptp4l_interface      => 'eth0',
  ptp4l_conf_slaveOnly => 1,
}
```

### Configure ptp in slave mode and use L2 message transport

```puppet
ptp::instance_ptp4l { 'ptp4l_instance4':
  ptp4l_interface              => 'eth0',
  ptp4l_conf_slaveOnly         => 1,
  ptp4l_conf_network_transport => 'L2'
}
```

### Configure ptp & phc2sys instances

Configure ptp instance in slave mode, sync eth0 to remote master or boundary clock;
Configure phc2sys to sync system clock to eth0 PHC clock.

```puppet
ptp::instance_ptp4l { 'ptp4l_instance0':
  ptp4l_interface              => 'eth0',
  ptp4l_conf_slaveOnly         => 1,
  ptp4l_conf_network_transport => 'UDPv4'
}

ptp::instance_phc2sys { 'phc2sys_instance0':
  phc2sys_slave              => 'CLOCK_REALTIME',
  phc2sys_master             => 'eth0',
}
```

### Configure Boundary Clock

Configure one ptp instance in slave mode, sync eth0 to remote master or boundary clock;
Configure second ptp instance in master mode, sync eth1 to eth0;
Configure third ptp instance in master mode, sync eth2 to eth0;

```puppet
ptp::instance_ptp4l { 'ptp4l_instance0':
  ptp4l_interface              => 'eth0',
  ptp4l_conf_slaveOnly         => 1,
}

ptp::instance_ptp4l { 'ptp4l_instance1':
  ptp4l_interface              => 'eth1',
  ptp4l_conf_slaveOnly         => 0,
}

ptp::instance_ptp4l { 'ptp4l_instance2':
  ptp4l_interface              => 'eth2',
  ptp4l_conf_slaveOnly         => 0,
}

ptp::instance_phc2sys { 'phc2sys_instance0':
  phc2sys_slave              => 'eth1',
  phc2sys_master             => 'eth0',
}

ptp::instance_phc2sys { 'phc2sys_instance0':
  phc2sys_slave              => 'eth2',
  phc2sys_master             => 'eth0',
}
```

In this case, eth0 will act as a slave and sync its PHC clock to remote master;
eth1 and eth2 will act as master in respective network where they connect.
phc2sys instances are created to sync eth1 and eth2 to eth0 hardware clock.


## Reference

### Classes

#### Public Classes

* ptp: Main class

#### Private Classes

* ptp::install: Handles package install/uninstall.
* ptp::ptp_config: Handles configuration files.
* ptp::ptp_service: Handles services.

#### Defined Type

* ptp::instance_ptp4l: single or multiple ptp4l instance creation
* ptp::instance_phc2sys: single or multiple phc2sys instance creation

### Parameters

The following parameters are available in the `::ptp` class:

```puppet
  Boolean $package_manage
  String  $package_name
  String  $package_ensure
  String  $ptp4l_confpath
  String  $ptp4l_service_confpath

  String  $ptp4l_default_service_name
  String  $ptp4l_service_ensure
  Boolean $ptp4l_service_enable
  Boolean $ptp4l_service_manage

  String  $phc2sys_default_service_name
  String  $phc2sys_service_ensure
  Boolean $phc2sys_service_enable
  Boolean $phc2sys_service_manage

  String  $phc2sys_opt_confpath
  String  $phc2sys_optfile
  String  $phc2sys_options

  String  $timemaster_service_name
  String  $timemaster_service_ensure
  Boolean $timemaster_service_enable
  Boolean $timemaster_service_manage

  String  $timemaster_conffile
  String  $timemaster_ntp_program
  Optional[String] $timemaster_chronyd_options
  String  $timemaster_ntp_server
  Integer $timemaster_ntp_server_minpoll
  Integer $timemaster_ntp_server_maxpoll
  Optional[String] $timemaster_ntpd_options
  String  $timemaster_ptp4l_interface
  Optional[String] $timemaster_ptp4l_options
  Optional[String] $timemaster_phc2sys_options
```

The following parameters are available in the `ptp::instance_ptp4l` defined type:

```puppet
  String  $ptp4l_interface
  Integer $ptp4l_conf_slaveOnly
  Integer $ptp4l_conf_logAnnounceInterval
  Integer $ptp4l_conf_logSyncInterval
  Integer $ptp4l_conf_logMinDelayReqInterval
  Integer $ptp4l_conf_logMinPdelayReqInterval
  String  $ptp4l_conf_clock_servo
  String  $ptp4l_conf_network_transport
```

The following parameters are available in the `ptp::instance_phc2sys` defined type:

```puppet
  String $phc2sys_slave
  String $phc2sys_master
```

## Limitations

The module is tested against Centos/RHEL 7.

## Development

PR acceptable.
