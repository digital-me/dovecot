# dovecot class
class dovecot(
  $package_configfiles  = 'keep',
  $mailpackages         = $::dovecot::params::mailpackages,
  $version              = $::dovecot::params::version,
  $augeas_path          = $::dovecot::params::augeas_path,
  $augeas_lenses        = $::dovecot::params::augeas_lenses,
) inherits ::dovecot::params {

  ensure_packages([$mailpackages], { 'configfiles' => $package_configfiles })

  exec { 'dovecot':
    command     => 'echo "dovecot packages are installed"',
    path        => '/usr/sbin:/bin:/usr/bin:/sbin',
    logoutput   => true,
    refreshonly => true,
    require     => Package[$mailpackages],
  }

  service { 'dovecot':
    ensure  => running,
    require => Exec['dovecot'],
    enable  => true
  }
}
