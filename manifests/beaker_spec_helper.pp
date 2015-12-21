class beaker_init::beaker_spec_helper(
  $project_dir
) {

  file { "${project_dir}/spec/spec_helper_acceptance.rb":
    ensure => 'file',
    mode   => '0644',
    source => 'puppet:///modules/beaker_init/spec/spec_helper_acceptance.rb',
  }

}
