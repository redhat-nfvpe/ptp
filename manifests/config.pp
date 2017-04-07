# This class handles ptp configuration files

class ptp::config inherits ptp {

  file { $ptp::ptp4l_optfile:
    ensure => file,
    owner => 0,
    group => 0,
    mode => '0644',
    content => epp('ptp/ptp4l.epp'),
  }

}
