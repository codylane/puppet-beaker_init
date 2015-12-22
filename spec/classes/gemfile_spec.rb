require 'spec_helper'

describe 'beaker_init::gemfile' do

  context 'without $path and $gems' do
    it { is_expected.to compile.and_raise_error(/expects a value for parameter 'gems'/) }
    it { is_expected.to compile.and_raise_error(/expects a value for parameter 'path'/) }
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
<<-EOS
source "https://rubygems.org"

puppetversion = ENV.key?('PUPPET_VERSION') ? "= \#{ENV['PUPPET_VERSION']}" : ['>= 3.3']

gem "present-gem"
gem "another-gem", :require => false, ">= 1.0.0"
gem "single-arg-gem", :require => true
EOS
    end

    it { should compile }

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
