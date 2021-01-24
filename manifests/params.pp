class dovecot::params () {
  # Package names per distro
  $mailpackages = $::osfamily ? {
    default  => ['dovecot-imapd', 'dovecot-pop3d'],
    'Debian' => ['dovecot-imapd', 'dovecot-pop3d'],
    'Redhat' => ['dovecot',]
  }

  # Augeas lenses sometime needs update
  # Most distros seem to use the same path so far:
  $augeas_path = '/usr/share/augeas/lenses/dist/'
  $augeas_latest = '1.12.0'

  if (versioncmp($::augeasversion, $augeas_latest) < 0) {
    $augeas_lenses = {
      'dovecot' => $augeas_latest,
      'build'   => $augeas_latest,
      'util'    => $augeas_latest,
    }
  } else {
    $augeas_lenses = {}
  }

  # Define some other useful variables based on distro
  # For instance, the major+minor version of Dovecot
  case "${::operatingsystem}-${::operatingsystemmajrelease}" {
    /(?i-mx:centos|redhat)-7/: {
      $version = '2.2'
    }
    /(?i-mx:centos|redhat)-8/: {
      $version = '2.3'
    }
    /(?i-mx:debian)-9/: {
      $version = '2.2'
    }
    /(?i-mx:debian)-10/: {
      $version = '2.3'
    }
    /(?i-mx:ubuntu)-16/: {
      $version = '2.2'
    }
    /(?i-mx:ubuntu)-18/: {
      $version = '2.2'
    }
    /(?i-mx:ubuntu)-20/: {
      $version = '2.3'
    }
    default: {
      $version = '2.0'
    }
  }
}
