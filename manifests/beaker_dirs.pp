#
class beaker_init::beaker_dirs(
  $project_dir,
) {

  # beaker specific setup
  file { "${project_dir}/spec":
    ensure => 'directory',
    mode   => '0755',
  }

  file { "${project_dir}/spec/acceptance":
    ensure => 'directory',
    mode   => '0755',
  }

  file { "${project_dir}/spec/acceptance/nodesets":
    ensure => 'directory',
    mode   => '0755',
  }

}
