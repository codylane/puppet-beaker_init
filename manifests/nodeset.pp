define beaker_init::nodeset(
  $project_dir,
  $nodeset_name          = $title,
  $ensure                = 'present',
  $roles                 = ['master', 'agent'],
  $platform              = 'el-6-x86_64',
  $hypervisor            = 'vagrant',
  $vagrant_box           = 'centos-65-x64-vbox436-nocm',
  $vagrant_box_url       = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box',
  $docker_image          = 'centos6.7',
  $docker_image_commands = [],
  $docker_preserve_image = false,
  $docker_cmd            = [],
  $snapshot              = undef,
  $config                = {},
  $extra                 = {},
) {

  file { "${project_dir}/spec/acceptance/nodesets/${nodeset_name}.yml":
    ensure  => 'file',
    mode    => '0644',
    content => template('beaker_init/nodeset.erb'),
  }
}
