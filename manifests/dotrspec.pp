#
define beaker_init::dotrspec(
  $project_dir = $beaker_init::project_dir,
) {
  include ::beaker_init

  file { "${project_dir}/.rspec":
    ensure  => 'file',
    content => template('beaker_init/rspec.erb'),
  }

}
