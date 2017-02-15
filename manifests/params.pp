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
    'beaker'                       => {
      'ensure'                     => 'present',
      'gem_attrs'                  => ["*location_for(ENV['BEAKER_VERSION'] || '~> 2.0')"],
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
    'rspec-puppet-facts'           => {
      'ensure'                     => 'present',
      'gem_attrs'                  => [':require => false']
    },
    'rspec'                        => {
      'ensure'                     => 'present',
      'gem_attrs'                  =>  [':require => false']
    },
    'mocha'                        => {
      'ensure'                     => 'present',
      'gem_attrs'                  =>  [':require => false'],
    },
    'mcollective-test'             => {
      'ensure'                     => 'present',
      'gem_attrs'                  => [':require => false'],
    },
    'deep_merge'                   => {
      'ensure'                     => 'present',
      'gem_attrs'                  =>  [':require => false'],
    },
    'rugged'                       => {
      'ensure'                     => 'present',
      'gem_attrs'                  =>  [':require => false'],
    },
    'hiera-eyaml'                  => {
      'ensure'                     => 'present',
      'gem_attrs'                  =>  [':require => false'],
    },
  }
}
