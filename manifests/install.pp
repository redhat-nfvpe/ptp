# This class handles ptp package

class ptp::install inherits ptp {
  
  if $ptp::package_manage {
    
    package { $ptp::package_name:
      ensure => $ptp::package_ensure,
    }

  }

  if $ptp::timemaster_service_manage {

    if $ptp::timemaster_ntp_program == 'chronyd' {
      package { 'chrony':
        ensure => present,
      }
    }
    elsif $ptp::timemaster_ntp_program == 'ntpd' {
      package { 'ntp':
        ensure => present,
      }
    }
    else {
        notice("timemaster ntp program should be specified when using timemaster service.")
    }

  }

}
