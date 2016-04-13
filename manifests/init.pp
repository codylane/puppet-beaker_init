# == Class: beaker_init
#
# This puppet module will help you create the skeleton needed to get beaker
# up and running with some very opinionated helper rake utilities for your
# testing enjoyment.
#
# WARNING: The class can be destructive if you are already using rspec-puppet
# beaker and have custom Gemfiles in your project root.  Please be sure to
# run puppet in `--noop` mode to see what changes puppet will make to an
# existing project.
#
# This class is responsible for setting up the following things for you:
#  * It will define a Gemfile that in your project root that is responsible
#    for installing rspec-puppet, beaker, puppet, facter... etc.
#  * It will define a Rakefile that (is more or less a copy) from
#    `puppet-module generate` with some added twists to allow you to easily
#    extend and add new functionality.  This module will provide you with some
#    of those additions.
#     * This module will create a `tasks` directory next to your `Rakefile`
#       which is where the custom help utilities will be defined.
#  * This class will define the following directory structure
#
#    spec -> The main
#     |
#     | - acceptance -> The beaker acceptance testing dir
#              |
#              | - nodesets -> Where you define your node definitions for
#                              beaker acceptance testing.
#
#  * It will define your `spec_helper.rb` with some added methods for helping
#    you in your unit tests.
#  * It will define your `spec_helper_acceptance.rb` with some customizations
#    that allow you to use hiera more easily without the need of re-defining
#    your hiera parameters inside your beaker tests.
#
# === Parameters
#
# [*project_dir*]
#   A fully qualified path to your puppet project.  This should be the root
#   directory of your project.
#
# [*gems*]
#   A hash of hashes that contain gem information for your Gemfile.
#   Default: `$beaker_init::params::gems`
#
#   Here is an example of what you want to override this setting:
#   ```
#   $gems = {
#     'rspec-puppet': {
#       'ensure'    => 'present',
#       'gem_attrs' => [':require => false', '">= 0.9.6"'],
#     },
#     'someothergem: {
#      'ensure' => 'absent',
#     },
#   }
#   ```
#
#   And if you want to override in hiera
#
#   ```
#   beaker_init::gems:
#     rspec-puppet:
#       ensure: present
#       gem_attrs:
#         - :require => false
#           ">= 0.9.6"
#     someothergme:
#       ensure: absent
#   ```
#
# [*define_raketasks*]
#  A boolean that toggles the custom rake tasks to be setup and included
#  in the `tasks` directory next to your Rakefile.
#  Default: `true`
#
# === Examples
#
#  class { 'beaker_init':
#    project_dir => '/path/to/my/project',
#  }
#
# === Authors
#
# Author Name Cody Lane
#
# 2015
#
class beaker_init(
  $project_dir,
  $gems              = $beaker_init::params::gems,
  $define_raketasks  = true,
  $gitignore_content = $beaker_init::params::gitignore_content,
) inherits beaker_init::params {

  validate_hash($gems)

  beaker_init::gitignore { "${project_dir}/.gitignore":
    content => $gitignore_content,
  }

  beaker_init::dotrspec { "${project_dir}/.rspec":
    content => "--format d\n--color",
  }

  class { 'beaker_init::gemfile':
    path => "${project_dir}/Gemfile",
    gems => $gems,
  }

  if $define_raketasks {
    class { 'beaker_init::raketask':
      project_dir => $project_dir,
    }
  }

  # beaker specific setup
  class { 'beaker_init::spec_dirs':
    project_dir => $project_dir,
  }

}
