require 'spec_helper'

describe 'beaker_init::gemfile' do

  context 'without $path and $gems' do
    it { is_expected.to compile.and_raise_error(/path/) }
  end

  context 'when $gems is a not a hash' do
    let(:params) do
      {
        :path => '/foo/project',
        :gems => ['should not work'],
      }
    end
    it { is_expected.to compile.and_raise_error(/is not a Hash/) }
  end

  context 'with $path and $gems' do
    let(:params) do
      {
        :path => '/foo/project/Gemfile',
        :gems => {
          'present-gem' => {
            'ensure' => 'present',
          },
          'absent-gem' => {
            'ensure' => 'absent'
          },
          'another-gem' => {
            'ensure'    => 'present',
            'gem_attrs' => [':require => false', '">= 1.0.0"'],
          },
          'single-arg-gem' => {
            'ensure'    => 'present',
            'gem_attrs' => [':require => true'],
          }
        }
      }
    end
    let(:expected_gemfile) do
<<-'EOS'
source "https://rubygems.org"

def location_for(place, fake_version = nil)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

ruby_ver = RUBY_VERSION.gsub(/\./, "").to_i
if ruby_ver < 225
  ENV['BEAKER_VERSION'].nil? ? ENV['BEAKER_VERSION'] = '2.51.0' : nil
else
  ENV['BEAKER_VERSION'].nil? ? ENV['BEAKER_VERSION'] = '3.10.0' : nil
end

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 3.3']

gem "present-gem"
gem "another-gem", :require => false, ">= 1.0.0"
gem "single-arg-gem", :require => true

mcollective_version = ENV['MCOLLECTIVE_GEM_VERSION']
if mcollective_version
  gem 'mcollective-client', mcollective_version, :require => false
else
  gem 'mcollective-client', :require => false
end
EOS
    end

    it { should compile }
    it { should contain_class('beaker_init::gemfile') }

    it do
      should contain_file('/foo/project/Gemfile').with({
        :ensure  => 'file',
        :mode    => '0644',
        :path    => '/foo/project/Gemfile',
        :content => expected_gemfile
      })
    end
  end

  context 'when $gems is an array' do
    let(:params) do
      {
        :path => '/foo/project/Gemfile',
        :gems => {
          'some-gem' => {
            'ensure' => 'present',
          }
        },
        :source => ['http://somewebsite.com', 'http://anotherwebsite.com'],
      }
    end

    let(:expected_gemfile) do
<<-'EOS'
source "http://somewebsite.com"
source "http://anotherwebsite.com"

def location_for(place, fake_version = nil)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

ruby_ver = RUBY_VERSION.gsub(/\./, "").to_i
if ruby_ver < 225
  ENV['BEAKER_VERSION'].nil? ? ENV['BEAKER_VERSION'] = '2.51.0' : nil
else
  ENV['BEAKER_VERSION'].nil? ? ENV['BEAKER_VERSION'] = '3.10.0' : nil
end

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 3.3']

gem "some-gem"

mcollective_version = ENV['MCOLLECTIVE_GEM_VERSION']
if mcollective_version
  gem 'mcollective-client', mcollective_version, :require => false
else
  gem 'mcollective-client', :require => false
end
EOS
    end

    it { should compile }
    it { should contain_class('beaker_init::gemfile') }

    it do
      should contain_file('/foo/project/Gemfile').with({
        :ensure  => 'file',
        :mode    => '0644',
        :path    => '/foo/project/Gemfile',
        :content => expected_gemfile
      })
    end
  end

  context 'when gems hash is an empty hash' do
    let(:params) do
      {
        :path => '/foo/project/Gemfile',
        :gems => {}
      }
    end

    let(:expected_gemfile) do
<<-'EOS'
source "https://rubygems.org"

def location_for(place, fake_version = nil)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

ruby_ver = RUBY_VERSION.gsub(/\./, "").to_i
if ruby_ver < 225
  ENV['BEAKER_VERSION'].nil? ? ENV['BEAKER_VERSION'] = '2.51.0' : nil
else
  ENV['BEAKER_VERSION'].nil? ? ENV['BEAKER_VERSION'] = '3.10.0' : nil
end

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['>= 3.3']


mcollective_version = ENV['MCOLLECTIVE_GEM_VERSION']
if mcollective_version
  gem 'mcollective-client', mcollective_version, :require => false
else
  gem 'mcollective-client', :require => false
end
EOS
    end

    it { should compile }
    it { should contain_class('beaker_init::gemfile') }

    it do
      should contain_file('/foo/project/Gemfile').with({
        :ensure  => 'file',
        :mode    => '0644',
        :path    => '/foo/project/Gemfile',
        :content => expected_gemfile
      })
    end

  end

end
