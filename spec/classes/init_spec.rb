require 'spec_helper'
describe 'beaker_init' do

  context 'with defaults for all parameters' do
    it { should contain_class('beaker_init') }
  end
end
