require 'spec_helper'
describe 'repoforge' do

  context 'with default values for all parameters' do
    it { should contain_class('repoforge') }
  end
end
