# This class handles ptp services

class ptp::service inherits ptp {
    
  if $ptp::timemaster_service_manage == true {
    service { 'ptp4l':
      ensure     => false,
      enable     => false,
      name       => $ptp::ptp4l_default_service_name,
      hasrestart => true,
    }
    service { 'phc2sys':
      ensure     => false,
      enable     => false,
      name       => $ptp::phc2sys_default_service_name,
      hasrestart => true,
    }
    service { 'timemaster':
      ensure     => $ptp::timemaster_service_ensure,
      enable     => $ptp::timemaster_service_enable,
      name       => $ptp::timemaster_service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
