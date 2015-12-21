class beaker_init::raketask(
  $project_dir,
){

  file { $project_dir:
    ensure => 'directory',
    mode   => '0755',
  }

  file { "${project_dir}/Rakefile":
    ensure => 'file',
    mode   => '0644',
    source => 'puppet:///modules/beaker_init/Rakefile',
  }

  file { "${project_dir}/tasks":
    ensure       => file,
    mode         => '0644',
    source       => "puppet:///modules/beaker_init/tasks/",
    sourceselect => 'all',
    recurse      => true,
  }

}
