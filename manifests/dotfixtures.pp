#
define beaker_init::dotfixtures(
  $project_dir = $beaker_init::project_dir,
  $mod_name = $title,
) {
  include ::beaker_init

  file { "${project_dir}/.fixtures.yml":
    ensure  => 'file',
    content => template('beaker_init/fixtures.yml.erb'),
  }

}
