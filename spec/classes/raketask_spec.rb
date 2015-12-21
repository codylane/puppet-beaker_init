require 'spec_helper'

describe 'beaker_init::raketask' do

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
    it { should contain_class('beaker_init::raketask') }

    it do
      should contain_file('/foo/project').with({
        :ensure => 'directory',
        :mode   => '0755',
      })
    end

    it do
      should contain_file('/foo/project/Rakefile').with({
        :ensure => 'file',
        :mode   => '0644',
        :source => 'puppet:///modules/beaker_init/Rakefile',
      })
    end

    it do
      should contain_file('/foo/project/tasks').with({
        :ensure  => 'file',
        :mode    => '0644',
        :source  => 'puppet:///modules/beaker_init/tasks/',
        :recurse => true,
      })
    end
  end

end
