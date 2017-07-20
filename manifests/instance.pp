# This class handles instance creation

define ptp::instance (
  String $ptp4l_interface                     = undef,
  Integer $ptp4l_conf_slaveOnly               = 0,
  Integer $ptp4l_conf_logAnnounceInterval     = 1,
  Integer $ptp4l_conf_logSyncInterval         = 0,
  Integer $ptp4l_conf_logMinDelayReqInterval  = 0,
  Integer $ptp4l_conf_logMinPdelayReqInterval = 0,
  String $ptp4l_conf_clock_servo              = 'pi',
  String $ptp4l_conf_network_transport        = 'UDPv4',
) {

   include ::ptp

   ptp::instance_config { $title:
     ptp4l_interface => $ptp4l_interface,
   }

   ptp::instance_service { $title:
     ptp4l_service_name => "ptp4l@${ptp4l_interface}",
   }

   Class['::ptp::install'] -> Ptp::Instance[$title]
   Class['::ptp::config']  -> Ptp::Instance[$title]
   Ptp::Instance_service[$title] -> Class['::ptp::service']

}
