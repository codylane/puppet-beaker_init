#
define beaker_init::gitignore(
  $project_dir = $beaker_init::project_dir,
) {

  include ::beaker_init

  file { "${project_dir}/.gitignore":
    ensure  => 'file',
    content => template('beaker_init/gitignore.erb'),
  }

}
