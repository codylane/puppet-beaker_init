require 'spec_helper'

describe 'beaker_init::spec_dirs' do

  context 'without $project_dir' do
    it { is_expected.to compile.and_raise_error(/expects a value for parameter 'project_dir'/) }
  end

  context 'with $project_dir' do
    let(:params) do
      {
        :project_dir => '/foo/project'
      }
    end

    it { should compile }

    it do
      should contain_file('/foo/project/spec').with({
        :ensure  => 'directory',
        :mode    => '0755',
        :source  => 'puppet:///modules/beaker_init/specs',
        :recurse => true
      })
    end

    it do
      should contain_file('/foo/project/spec/acceptance').with({
        :ensure => 'directory',
        :mode   => '0755',
      })
    end

    it do
      should contain_file('/foo/project/spec/acceptance/nodesets').with({
        :ensure  => 'directory',
        :mode    => '0755',
      })
    end
  end

end
