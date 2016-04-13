#
define beaker_init::gitignore(
  $project_dir = $beaker_init::project_dir,
  $content     = $beaker_init::params::gitignore_content,
) {

  include ::beaker_init

  file { "${project_dir}/.gitignore":
    ensure  => 'file',
    content => $content,
  }

}
