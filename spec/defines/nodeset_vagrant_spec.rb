require 'spec_helper'

describe 'beaker_init::nodeset', :type => :define do

  context 'without project_dir' do
    let(:title) { 'default' }

    it { is_expected.to compile.and_raise_error(/project_dir/) }
  end

  context 'with project_dir' do
    let(:params) do
      {
        :project_dir  => '/foo/project',
      }
    end

    let(:title) { 'default' }

    it { should compile }
    it { should contain_class('beaker_init') }
    it { should contain_beaker_init__gitignore('/foo/project/.gitignore') }
    it { should contain_beaker_init__dotrspec('/foo/project/.rspec') }
    it { should contain_beaker_init__dotfixtures('/foo/project/.fixtures.yml') }
    it { should contain_class('beaker_init::raketask') }
    it { should contain_class('beaker_init::gemfile') }
    it { should contain_class('beaker_init::spec_dirs') }

    let(:default_nodeset) do
<<-EOS
HOSTS:
  default:
    roles:
      - master
      - agent
    platform: el-6-x86_64
    hypervisor: vagrant
    box: centos-6.6-64-nocm
    box_url: https://atlas.hashicorp.com/puppetlabs/centos-6.6-64-nocm
    vb_gui: false
CONFIG:
  type: foss
EOS
    end

    it do
      should contain_file('/foo/project/spec/acceptance/nodesets/default.yml').with({
        :ensure  => 'file',
        :mode    => '0644',
        :content => default_nodeset
      })
    end
  end

  context 'when hypervisor=vagrant' do
    let(:params) do
      {
        :project_dir     => '/foo/project',
        :hypervisor      => 'vagrant',
        :vagrant_box     => 'some-box-name',
        :vagrant_box_url => 'http://host/some-box-name.box',
      }
    end

    let(:title) { 'default' }

    let(:default_nodeset) do
<<-EOS
HOSTS:
  default:
    roles:
      - master
      - agent
    platform: el-6-x86_64
    hypervisor: vagrant
    box: some-box-name
    box_url: http://host/some-box-name.box
    vb_gui: false
CONFIG:
  type: foss
EOS
    end

    it { should compile }
    it { should contain_class('beaker_init') }
    it { should contain_beaker_init__gitignore('/foo/project/.gitignore') }
    it { should contain_beaker_init__dotrspec('/foo/project/.rspec') }
    it { should contain_beaker_init__dotfixtures('/foo/project/.fixtures.yml') }
    it { should contain_class('beaker_init::raketask') }
    it { should contain_class('beaker_init::gemfile') }
    it { should contain_class('beaker_init::spec_dirs') }

    it do
      should contain_file('/foo/project/spec/acceptance/nodesets/default.yml').with({
        :ensure  => 'file',
        :mode    => '0644',
        :content => default_nodeset
      })
    end
  end

  context 'when hypervisor=docker' do
    let(:params) do
      {
        :project_dir           => '/foo/project',
        :hypervisor            => 'docker',
        :docker_image_commands => ['run this', 'then run this'],
        :docker_preserve_image => false,
        :docker_cmd            => ['/sbin/init'],
      }
    end

    let(:title) { 'docker-default' }

    let(:default_nodeset) do
<<-EOS
HOSTS:
  docker-default:
    roles:
      - master
      - agent
    platform: el-6-x86_64
    hypervisor: docker
    image: centos:6
    docker_image_commands:
      - run this
      - then run this
    docker_cmd: ["/sbin/init"]
    docker_preserve_image: false
CONFIG:
  type: foss
EOS
    end

    it { should compile }
    it { should contain_class('beaker_init') }
    it { should contain_beaker_init__gitignore('/foo/project/.gitignore') }
    it { should contain_beaker_init__dotrspec('/foo/project/.rspec') }
    it { should contain_beaker_init__dotfixtures('/foo/project/.fixtures.yml') }
    it { should contain_class('beaker_init::raketask') }
    it { should contain_class('beaker_init::gemfile') }
    it { should contain_class('beaker_init::spec_dirs') }

    it do
      should contain_file('/foo/project/spec/acceptance/nodesets/docker-default.yml').with({
        :ensure  => 'file',
        :mode    => '0644',
        :content => default_nodeset
      })
    end

    describe 'without docker_image_commands, docker_preserve_image, docker_image' do
      let(:params) do
        {
          :project_dir => '/foo/project',
          :hypervisor => 'docker'
        }
      end

      let(:title) { 'docker-default2' }
      let(:default_nodeset) do
<<-EOS
HOSTS:
  docker-default2:
    roles:
      - master
      - agent
    platform: el-6-x86_64
    hypervisor: docker
    image: centos:6
    docker_preserve_image: false
CONFIG:
  type: foss
EOS
      end

      it { should compile }
      it { should contain_class('beaker_init') }
      it { should contain_beaker_init__gitignore('/foo/project/.gitignore') }
      it { should contain_beaker_init__dotrspec('/foo/project/.rspec') }
      it { should contain_beaker_init__dotfixtures('/foo/project/.fixtures.yml') }
      it { should contain_class('beaker_init::raketask') }
      it { should contain_class('beaker_init::gemfile') }
      it { should contain_class('beaker_init::spec_dirs') }

      it do
        should contain_file('/foo/project/spec/acceptance/nodesets/docker-default2.yml').with({
          :ensure  => 'file',
          :mode    => '0644',
          :content => default_nodeset
        })
      end

    end
  end

  context 'with snapshot=somevalue' do
    let(:params) do
      {
        :project_dir => '/foo/project',
        :snapshot    => 'somevalue',
      }
    end

    let(:title) { 'snapshot-default' }

    let(:default_nodeset) do
<<-EOS
HOSTS:
  snapshot-default:
    roles:
      - master
      - agent
    platform: el-6-x86_64
    hypervisor: vagrant
    box: centos-6.6-64-nocm
    box_url: https://atlas.hashicorp.com/puppetlabs/centos-6.6-64-nocm
    vb_gui: false
    snapshot: somevalue
CONFIG:
  type: foss
EOS
    end

    it { should compile }
    it { should contain_class('beaker_init') }
    it { should contain_beaker_init__gitignore('/foo/project/.gitignore') }
    it { should contain_beaker_init__dotrspec('/foo/project/.rspec') }
    it { should contain_beaker_init__dotfixtures('/foo/project/.fixtures.yml') }
    it { should contain_class('beaker_init::raketask') }
    it { should contain_class('beaker_init::gemfile') }
    it { should contain_class('beaker_init::spec_dirs') }

    it do
      should contain_file('/foo/project/spec/acceptance/nodesets/snapshot-default.yml').with({
        :ensure  => 'file',
        :mode    => '0644',
        :content => default_nodeset
      })
    end

  end

  context 'parameters passed in via hiera' do
    hiera_config = get_hiera_config
    hiera = Hiera.new(:config => hiera_config)
    nodesets = hiera.lookup('beaker_nodesets', nil, nil)

    describe "for foo_project hiera section" do
      let(:title) { 'foo_project' }
      let(:params) { nodesets['foo_project'] }
      let(:nodeset_output) do
<<-EOS
HOSTS:
  foo_project:
    roles:
      - agent
    platform: el-6-x86_64
    hypervisor: vagrant
    box: centos-6u7
    box_url: http://somehost.example.com/centos-6u7.box
    vb_gui: false
CONFIG:
  type: foss
ssh:
  password: somestring
EOS
      end

      it { should compile }

      describe 'contain defined type beaker_init::dotrspec' do
        it { should contain_beaker_init__dotrspec('/tmp/project/.rspec') }
        it { should contain_file('/tmp/project/.rspec').with_ensure('file') }
      end

      describe 'contain defined type beaker_init::dotfixtures' do
        it { should contain_beaker_init__dotfixtures('/tmp/project/.fixtures.yml') }
        it { should contain_file('/tmp/project/.fixtures.yml').with_ensure('file') }
      end

      describe 'contain defined type beaker_init::gitignore' do
        it { should contain_beaker_init__gitignore('/tmp/project/.gitignore') }
        it { should contain_file('/tmp/project/.gitignore').with_ensure('file') }
      end

      describe 'contain class[beaker_init]' do
        it { should contain_class('beaker_init') }
        it { should contain_file('/tmp/project') }
      end

      describe 'contain class[beaker_init::raketask' do
        it { should contain_class('beaker_init::raketask') }
        it { should contain_file('/tmp/project/Rakefile') }
        it { should contain_file('/tmp/project/tasks') }
      end

      describe 'contain class[beaker_init::gemfile]' do
        it { should contain_class('beaker_init::gemfile') }
        it { should contain_file('/tmp/project/Gemfile') }
      end

      describe 'contain class[beaker_init::spec_dirs]' do
        it { should contain_class('beaker_init::spec_dirs') }
        it { should contain_file('/tmp/project/spec/') }
        it { should contain_file('/tmp/project/spec/acceptance') }
        it { should contain_file('/tmp/project/spec/acceptance/nodesets') }
      end

      it do
        should contain_file("/tmp/project/spec/acceptance/nodesets/#{title}.yml").with({
          :ensure  => 'file',
          :mode    => '0644',
          :content => nodeset_output
        })
      end
    end
  end

end
