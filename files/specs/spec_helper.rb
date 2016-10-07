require 'puppetlabs_spec_helper/module_spec_helper'
require 'hiera'
require 'rspec-puppet-facts'
include RspecPuppetFacts

# require Puppet::Resource::Catalog::Compiler
require 'puppet/indirector/catalog/compiler'

# Magic to add a catalog.exported_resources accessor
class Puppet::Resource::Catalog::Compiler
  alias_method :filter_exclude_exported_resources, :filter
  def filter(catalog)
    filter_exclude_exported_resources(catalog).tap do |filtered|
      # Every time we filter a catalog, add a .exported_resources to it.
      filtered.define_singleton_method(:exported_resources) do
        # The block passed to filter returns `false` if it wants to keep a resource. Go figure.
        catalog.filter { |r| !r.exported? }
      end
    end
  end
end

module Support
  module ExportedResources
    # Get exported resources as a catalog. Compatible with all catalog matchers, e.g.
    # `expect(exported_resources).to contain_myexportedresource('name').with_param('value')`
    def exported_resources
      # Catalog matchers expect something that can receive .call
      proc { subject.call.exported_resources }
    end
  end
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

def get_hiera_config
  hiera_dir = get_spec_fixtures_dir
  hiera_conf = hiera_dir + '/hiera.yaml'

  hiera_conf
end

def hiera_lookup(key, scope, resolution_type={:behavior => :deeper})
  @hiera = Hiera.new(:config => get_hiera_config)
  result = @hiera.lookup(key, nil, scope, nil, resolution_type)

  result
end

RSpec.configure do |c|
  # c.hiera_config = get_hiera_config
end

# Include code coverage report for all our specs
at_exit { RSpec::Puppet::Coverage.report! }
