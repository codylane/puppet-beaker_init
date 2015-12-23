require 'spec_helper'

describe 'beaker_init::nodeset', :type => :define do

  context 'without project_dir' do
    let(:title) { 'default' }

    it { is_expected.to compile.and_raise_error(/expects a value for parameter 'project_dir'/) }
  end

  context 'with project_dir' do
    let(:params) do
      {
        :project_dir  => '/foo/project',
      }
    end

    let(:title) { 'default' }

    it { should compile }

    let(:default_nodeset) do
<<-EOS
HOSTS:
  default:
    roles:
      - master
      - agent
    platform: el-6-x86_64
    hypervisor: vagrant
    box: centos-65-x64-vbox436-nocm
    box_url: http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box
    vb_gui: false
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
EOS
    end

    it { should compile }

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
    docker_image_commands:
      - run this
      - then run this
    docker_cmd: ["/sbin/init"]
    docker_preserve_image: false
EOS
    end

    it { should compile }

    it do
      should contain_file('/foo/project/spec/acceptance/nodesets/docker-default.yml').with({
        :ensure  => 'file',
        :mode    => '0644',
        :content => default_nodeset
      })
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
    box: centos-65-x64-vbox436-nocm
    box_url: http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box
    vb_gui: false
    snapshot: somevalue
EOS
    end

    it { should compile }

    it do
      should contain_file('/foo/project/spec/acceptance/nodesets/snapshot-default.yml').with({
        :ensure  => 'file',
        :mode    => '0644',
        :content => default_nodeset
      })
    end

  end

end
