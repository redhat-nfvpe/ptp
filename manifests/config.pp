# This class handles ptp configuration files

class ptp::config inherits ptp {

  if $ptp::timemaster_service_manage == true {

    file { $ptp::timemaster_conffile:
      ensure => file,
      owner => 0,
      group => 0,
      mode => '0644',
      content => epp('ptp/timemaster.conf.epp')
    }

  }
  else {

    file { "ptp4l@.service":
      ensure => file,
      owner => 0,
      group => 0,
      mode => '0644',
      path => "${ptp::ptp4l_service_confpath}/ptp4l@.service",
      content => epp('ptp/ptp4l.service.epp'),
    }

    file { "phc2sys@.service":
      ensure => file,
      owner => 0,
      group => 0,
      mode => '0644',
      path => "${ptp::phc2sys_service_confpath}/phc2sys@.service",
      content => epp('ptp/phc2sys.service.epp'),
    }

  }

}
