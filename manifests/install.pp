# This class handles ptp package

class ptp::install inherits ptp {
  
  if $ptp::package_manage {
    
    package { $ptp::package_name:
      ensure => $ptp::package_ensure,
    }

  }

}
