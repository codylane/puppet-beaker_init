#
class beaker_init::params {
  $gemfile = '/tmp/Gemfile'

  $gems    = {
    'puppet'                       => {
      'ensure'                     => 'present',
      'path'                       => $gemfile,
      'gem_attrs'                  => ['puppetversion'],
    },
    'puppetlabs_spec_helper'       =>  {
      'ensure'                     => 'present',
      'path'                       => $gemfile,
      'gem_attrs'                  => ['">= 0.1.0"'],
    },
    'puppet-lint'                  => {
      'ensure'                     => 'present',
      'path'                       => $gemfile,
      'gem_attrs'                  => ['">= 0.3.2"'],
    },
    'facter'                       => {
      'ensure'                     => 'present',
      'path'                       => $gemfile,
      'gem_attrs'                  => ['">= 1.7.0"'],
    },
    'beaker-puppet_install_helper' => {
      'ensure'                     => 'present',
      'path'                       => $gemfile,
      'gem_attrs'                  =>  [':require => false'],
    },
    'beaker_spec_helper'           => {
      'ensure'                     => 'present',
      'path'                       => $gemfile,
      'gem_attrs'                  => [':require => false'],
    },
    'beaker-hiera'                 => {
      'ensure'                     => 'present',
      'path'                       => $gemfile,
      'gem_attrs'                  => [':require => false'],
    },
    'simplecov'                    => {
      'ensure'                     => 'present',
      'path'                       => $gemfile,
      'gem_attrs'                  => [':require => false'],
    },
    'puppet_facts'                 => {
      'ensure'                     => 'present',
      'path'                       => $gemfile,
      'gem_attrs'                  => [':require => false'],
    },
    'json'                         => {
      'ensure'                     => 'present',
      'path'                       => $gemfile,
      'gem_attrs'                  => [':require => false'],
    },
    'beaker-rspec'                 => {
      'ensure'                     => 'present',
      'path'                       => $gemfile,
      'gem_attrs'                  => [':require => false'],
    },
    'serverspec'                   => {
      'ensure'                     => 'present',
      'path'                       => $gemfile,
      'gem_attrs'                  => [':require => false'],
    },
  }

}
