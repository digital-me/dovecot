# == Class: dovecot::config::augeas
#
# Update some Augeas lenses for some cases - see params
#
class dovecot::config::augeas {
  $augeas_path   = $::dovecot::augeas_path
  $augeas_lenses = $::dovecot::augeas_lenses

  File {
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644'
  }

  if ($augeas_lenses != '') {
    $augeas_lenses.each |$lens,$update| {
      if ($update) {
        file { "dovecot-augeas-${lens}-lens-update":
          path   => "${augeas_path}/${lens}.aug",
          source => "puppet:///modules/dovecot/${lens}-${update}.aug",
        }
      }
    }
  }
}
