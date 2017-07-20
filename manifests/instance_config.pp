# This class handles instance config

define ptp::instance_config (
    String $ptp4l_interface = undef,
) {

    file { "ptp4l-${title}-${ptp4l_interface}.conf":
      ensure => file,
      owner => 0,
      group => 0,
      mode => '0644',
      path => "${ptp::ptp4l_confpath}/ptp4l-${ptp4l_interface}.conf",
      content => epp('ptp/ptp4l.conf.epp'),
    }

}
