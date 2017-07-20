# This class handles instance service

define ptp::instance_service (
    String $ptp4l_service_name = undef,
) {
    if $ptp::ptp4l_service_manage == true {
      service { $title:
        ensure     => $ptp::ptp4l_service_ensure,
        enable     => $ptp::ptp4l_service_enable,
        name       => $ptp4l_service_name,
        hasstatus  => true,
        hasrestart => true,
      }
    }

}
