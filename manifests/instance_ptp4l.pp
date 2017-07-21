# This class handles instance creation

define ptp::instance_ptp4l (
  String  $ptp4l_interface                    = undef,
  Integer $ptp4l_conf_slaveOnly               = 0,
  Integer $ptp4l_conf_logAnnounceInterval     = 1,
  Integer $ptp4l_conf_logSyncInterval         = 0,
  Integer $ptp4l_conf_logMinDelayReqInterval  = 0,
  Integer $ptp4l_conf_logMinPdelayReqInterval = 0,
  String  $ptp4l_conf_clock_servo             = 'pi',
  String  $ptp4l_conf_network_transport       = 'UDPv4',
) {

   include ::ptp

   file { "ptp4l-${title}-${ptp4l_interface}.conf":
     ensure => file,
     owner => 0,
     group => 0,
     mode => '0644',
     path => "${ptp::ptp4l_confpath}/ptp4l-${ptp4l_interface}.conf",
     content => template('ptp/ptp4l.conf.epp'),
   }

   if $ptp::ptp4l_service_manage == true {
     service { $title:
       ensure     => $ptp::ptp4l_service_ensure,
       enable     => $ptp::ptp4l_service_enable,
       name       => "ptp4l@${ptp4l_interface}",
       hasstatus  => true,
       hasrestart => true,
     }
   }

   Class['::ptp::install'] -> Ptp::Instance_ptp4l[$title]
   Class['::ptp::config']  -> Ptp::Instance_ptp4l[$title]

}
