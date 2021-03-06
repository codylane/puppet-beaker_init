#
class beaker_init::gemfile(
  $path,
  $gems,
  $source = 'https://rubygems.org',
) {

  validate_hash($gems)

  file { $path:
    ensure  => 'file',
    mode    => '0644',
    content => template('beaker_init/gemfile.erb')
  }

}
