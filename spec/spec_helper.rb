require 'puppetlabs_spec_helper/module_spec_helper'
require 'hiera'

def get_hiera_config
  hiera_dir = get_spec_fixtures_dir
  hiera_conf = hiera_dir + '/hiera.yaml'

  raise "hiera.yaml does not exist at #{hiera_conf}" unless File.exists? hiera_conf

  hiera_conf
end

def get_spec_fixtures_dir
  spec_dir = File.expand_path(File.dirname(__FILE__) + '/fixtures')

  raise "The directory #{spec_dir} does not exist" unless Dir.exists? spec_dir

  spec_dir
end

def read_fixture_file filename
  filename = get_spec_fixtures_dir + "/#{filename}"

  raise "The fixture file #{filename} doesn't exist" unless File.exists? filename

  File.read(filename)
end

RSpec.configure do |c|
  c.hiera_config = get_hiera_config
end

# Include code coverage report for all our specs
at_exit { RSpec::Puppet::Coverage.report! }
