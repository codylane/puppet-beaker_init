#
class beaker_init::params {
  $gemfile = '/tmp/Gemfile'

  $gems    = {
    'puppet'                       => {
      'ensure'                     => 'present',
      'gem_attrs'                  => ['puppetversion'],
    },
    'puppetlabs_spec_helper'       =>  {
      'ensure'                     => 'present',
      'gem_attrs'                  => ['">= 0.1.0"'],
    },
    'puppet-lint'                  => {
      'ensure'                     => 'present',
      'gem_attrs'                  => ['">= 0.3.2"'],
    },
    'facter'                       => {
      'ensure'                     => 'present',
      'gem_attrs'                  => ['">= 1.7.0"'],
    },
    'beaker-puppet_install_helper' => {
      'ensure'                     => 'present',
      'gem_attrs'                  =>  [':require => false'],
    },
    'beaker_spec_helper'           => {
      'ensure'                     => 'present',
    },
    'beaker-hiera'                 => {
      'ensure'                     => 'present',
      'gem_attrs'                  => [':require => false'],
    },
    'simplecov'                    => {
      'ensure'                     => 'present',
      'gem_attrs'                  => [':require => false'],
    },
    'puppet_facts'                 => {
      'ensure'                     => 'present',
      'gem_attrs'                  => [':require => false'],
    },
    'json'                         => {
      'ensure'                     => 'present',
      'gem_attrs'                  => [':require => false'],
    },
    'beaker-rspec'                 => {
      'ensure'                     => 'present',
      'gem_attrs'                  => [':require => false'],
    },
    'serverspec'                   => {
      'ensure'                     => 'present',
      'gem_attrs'                  => [':require => false'],
    },
  }

}
