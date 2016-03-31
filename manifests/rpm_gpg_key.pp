# Define repoforge::rpm_gpg_key
# ===========================
#
# Import the RPM GPG key.
#
# Parameters
# ----------
#
# * `path`
# The path to the RPM-GPG-KEY file to manage. Must be an absolute path.
#
define repoforge::rpm_gpg_key (
  $path,
){

  validate_absolute_path($path)

  exec { "import-${name}":
    command => "rpm --import ${path}",
    path    => ['/bin', '/usr/bin'],
    unless  => "rpm -q gpg-pubkey-$(gpg --throw-keyids ${path} | grep pub | cut -c 12-19 | tr '[A-Z]' '[a-z]')",
    require => File[$path],
  }

}
