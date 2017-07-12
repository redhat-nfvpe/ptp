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

    file { $ptp::ptp4l_optfile:
      ensure => file,
      owner => 0,
      group => 0,
      mode => '0644',
      content => epp('ptp/ptp4l.epp'),
    }

    file { $ptp::ptp4l_conffile:
      ensure => file,
      owner => 0,
      group => 0,
      mode => '0644',
      content => epp('ptp/ptp4l.conf.epp'),
    }

    file { $ptp::phc2sys_optfile:
      ensure => file,
      owner => 0,
      group => 0,
      mode => '0644',
      content => epp('ptp/phc2sys.epp'),
    }

  }

}
