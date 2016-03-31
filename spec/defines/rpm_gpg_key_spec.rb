require 'spec_helper'
describe 'repoforge::rpm_gpg_key' do
  context 'dag' do
    let(:title) { 'dag' }
    let(:params) {{ path: '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag' }}

    it { should contain_exec('import-dag').with_command('rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag') }
  end

  context 'fabian' do
    let(:title) { 'fabian' }
    let(:params) {{ path: '/etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-fabian' }}

    it { should contain_exec('import-fabian').with_command('rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-fabian') }
  end
end
