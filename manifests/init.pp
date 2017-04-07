# Class: ptp
# ===========================
#
# Full description of class ptp here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'ptp':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class ptp (
  Boolean $package_manage,
  String $package_name,
  String $package_ensure,
  String $ptp4l_service_name,
  String $ptp4l_service_ensure,
  Boolean $ptp4l_service_enable,
  Boolean $ptp4l_service_manage,
  String $phc2sys_service_name,
  String $phc2sys_service_ensure,
  Boolean $phc2sys_service_enable,
  Boolean $phc2sys_service_manage,
  String $ptp4l_interface,
  String $ptp4l_conffile,
  String $ptp4l_optfile,
  Optional[Integer] $ptp4l_conf_slaveOnly,
  Optional[Integer] $ptp4l_conf_logAnnounceInterval,
  Optional[Integer] $ptp4l_conf_logSyncInterval,
  Optional[Integer] $ptp4l_conf_logMinDelayReqInterval,
  Optional[Integer] $ptp4l_conf_logMinPdelayReqInterval,
  Optional[String] $ptp4l_conf_clock_servo,
  String $ptp4l_conf_network_transport,
) {

  contain ptp::install
  contain ptp::config
  contain ptp::service

  Class['::ptp::install'] ->
  Class['::ptp::config'] ~>
  Class['::ptp::service']
}
