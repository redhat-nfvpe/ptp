require 'spec_helper'
describe 'ptp' do
  context 'with default values for all parameters' do
    it { should contain_class('ptp') }
  end
end
