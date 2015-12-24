define create_nodeset(
  $project_dir,
  $project_name    = $title,
  $beaker_nodesets = hiera('beaker_nodesets'),
) {

   create_resources(beaker_init::nodeset, $beaker_nodesets[$project_name])
}

node default {
  create_nodeset { 'example_project':
    project_dir => '/tmp/example_project'
  }
}
