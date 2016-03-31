# Class: repoforge
# ===========================
#
# Configure the repoforge repository and import the GPG keys.
#
class repoforge (
  $rpmforge_baseurl            = "http://apt.sw.be/redhat/el${::operatingsystemmajrelease}/en/\$basearch/rpmforge",
  $rpmforge_mirrorlist         = "http://mirrorlist.repoforge.org/el${::operatingsystemmajrelease}/mirrors-rpmforge",
  $rpmforge_enabled            = 1,
  $rpmforge_gpgcheck           = 1,

  $rpmforge_extras_baseurl     = "http://apt.sw.be/redhat/el${::operatingsystemmajrelease}/en/\$basearch/extras",
  $rpmforge_extras_mirrorlist  = "http://mirrorlist.repoforge.org/el${::operatingsystemmajrelease}/mirrors-rpmforge-extras",
  $rpmforge_extras_enabled     = 0,
  $rpmforge_extras_gpgcheck    = 1,

  $rpmforge_testing_baseurl    = "http://apt.sw.be/redhat/el${::operatingsystemmajrelease}/en/\$basearch/testing",
  $rpmforge_testing_mirrorlist = "http://mirrorlist.repoforge.org/el${::operatingsystemmajrelease}/mirrors-rpmforge-testing",
  $rpmforge_testing_enabled    = 0,
  $rpmforge_testing_gpgcheck   = 1,
){

  require epel

  if ($::osfamily == 'RedHat' and $::operatingsystem !~ /Fedora|Amazon/) {
    yumrepo {
      'rpmforge':
        descr      => 'RHEL $releasever - RPMforge.net - dag',
        baseurl    => $rpmforge_baseurl,
        mirrorlist => $rpmforge_mirrorlist,
        enabled    => $rpmforge_enabled,
        gpgcheck   => $rpmforge_gpgcheck,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag';

      'rpmforge-extras':
        descr      => 'RHEL $releasever - RPMforge.net - extras',
        baseurl    => $rpmforge_extras_baseurl,
        mirrorlist => $rpmforge_extras_mirrorlist,
        enabled    => $rpmforge_extras_enabled,
        gpgcheck   => $rpmforge_extras_gpgcheck,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag';

      'rpmforge-testing':
        descr      => 'RHEL $releasever - RPMforge.net - testing',
        baseurl    => $rpmforge_testing_baseurl,
        mirrorlist => $rpmforge_testing_mirrorlist,
        enabled    => $rpmforge_testing_enabled,
        gpgcheck   => $rpmforge_testing_gpgcheck,
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag';
    }

    file {
      '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => file('repoforge/RPM-GPG-KEY-rpmforge-dag');

      '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-fabian':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => file('repoforge/RPM-GPG-KEY-rpmforge-fabian');
    }

    repoforge::rpm_gpg_key {
      'dag':
        path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag';

      'fabian':
        path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-fabian';
    }
  } else {
    notice("This repoforge module does not support ${::operatingsystem}.")
  }

}
