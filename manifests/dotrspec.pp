#
define beaker_init::dotrspec(
  $project_dir = $beaker_init::project_dir,
  $content     = "--format d\n--color",
) {

  file { "${project_dir}/.rspec":
    ensure  => 'file',
    content => $content,
  }

}
