require 'spec_helper'

describe 'beaker_init' do

  context 'when project_dir is not defined' do
    it { is_expected.to compile.and_raise_error(/expects a value for parameter 'project_dir'/) }
  end

  context 'when project_dir => /foo/project' do
    let(:params) do
      {
        :project_dir => '/foo/project',
      }
    end

    it { should compile }

    context 'contain beaker_init' do
      it { should contain_class('beaker_init') }
      it { should contain_class('beaker_init::params') }
      it { should contain_file('/foo/project') }
    end

    context 'contain class beaker_init::gemfile' do
      it { should contain_class('beaker_init::gemfile') }
      it { should contain_file('/foo/project/Gemfile') }
    end

    context 'contain beaker_init::raketask' do
      it { should contain_class('beaker_init::raketask') }
      it { should contain_file('/foo/project/Rakefile') }
      it { should contain_file('/foo/project/tasks') }
    end

    context 'contain beaker_init::beaker_dirs' do
      it { should contain_class('beaker_init::beaker_dirs') }
      it { should contain_file('/foo/project/spec/acceptance/nodesets') }
      it { should contain_file('/foo/project/spec/acceptance') }
      it { should contain_file('/foo/project/spec/') }
    end

  end

  context 'when define_raketasks => false' do
    let(:params) do
      {
        :project_dir      => '/foo/project',
        :define_raketasks => false
      }
    end

    it { should compile }
    it { should contain_class('beaker_init') }
    it { should contain_class('beaker_init::params') }
    it { should contain_class('beaker_init::gemfile') }
    it { should_not contain_class('beaker_init::raketask') }
    it { should contain_class('beaker_init::beaker_dirs') }
  end

end
