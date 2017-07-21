# This class handles instance creation

define ptp::instance_phc2sys (
  Boolean $auto_sync              = false,
  String $phc2sys_slave           = 'CLOCK_REALTIME',
  String $phc2sys_master          = 'CLOCK_REALTIME',
) {

   include ::ptp

   if $ptp::phc2sys_service_manage == true {
     if $auto_sync == true {
        service { 'phc2sys':
          ensure     => $ptp::phc2sys_service_ensure,
          enable     => $ptp::phc2sys_service_enable,
          name       => $ptp::phc2sys_default_service_name,
          hasstatus  => true,
          hasrestart => true,
        }
     }
     else {
        file { "phc2sys-${title}":
          ensure => file,
          owner => 0,
          group => 0,
          mode => '0644',
          path => "${ptp::phc2sys_opt_confpath}/phc2sys-${phc2sys_slave}-${phc2sys_master}",
          content => template('ptp/phc2sys.epp')
        }
        service { $title:
          ensure     => $ptp::phc2sys_service_ensure,
          enable     => $ptp::phc2sys_service_enable,
          name       => "phc2sys@phc2sys-${phc2sys_slave}-${phc2sys_master}",
          hasstatus  => true,
          hasrestart => true,
        }
     }
   }

   Class['::ptp::install'] -> Ptp::Instance_phc2sys[$title]
   Class['::ptp::config']  -> Ptp::Instance_phc2sys[$title]

}
