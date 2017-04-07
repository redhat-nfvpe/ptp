# This class handles ptp services

class ptp::service inherits ptp {
    
  if $ptp::ptp4l_service_manage == true {
    service { 'ptp4l':
      ensure     => $ptp::ptp4l_service_ensure,
      enable     => $ptp::ptp4l_service_enable,
      name       => $ptp::ptp4l_service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

  if $ptp::phc2sys_service_manage == true {
    service { 'ptp4l':
      ensure     => $ptp::phc2sys_service_ensure,
      enable     => $ptp::phc2sys_service_enable,
      name       => $ptp::phc2sys_service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
