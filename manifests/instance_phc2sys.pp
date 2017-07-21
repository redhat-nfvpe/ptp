# This class handles instance creation

define ptp::instance_phc2sys (
  String $phc2sys_slave           = 'CLOCK_REALTIME',
  String $phc2sys_master          = undef,
) {

   include ::ptp

   file { "phc2sys-${title}":
     ensure => file,
     owner => 0,
     group => 0,
     mode => '0644',
     path => "${ptp::phc2sys_opt_confpath}/phc2sys-${phc2sys_slave}-${phc2sys_master}",
     content => template('ptp/phc2sys.epp')
   }

   if $ptp::phc2sys_service_manage == true {
     service { $title:
       ensure     => $ptp::phc2sys_service_ensure,
       enable     => $ptp::phc2sys_service_enable,
       name       => "phc2sys@${phc2sys_slave}-${phc2sys_master}",
       hasstatus  => true,
       hasrestart => true,
     }
   }

   Class['::ptp::install'] -> Ptp::Instance_phc2sys[$title]
   Class['::ptp::config']  -> Ptp::Instance_phc2sys[$title]

}
