#
class beaker_init::spec_dirs(
  $project_dir,
) {

  # beaker specific setup
  file { "${project_dir}/spec":
    ensure  => 'directory',
    mode    => '0755',
    source  => 'puppet:///modules/beaker_init/specs',
    recurse => true,
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
