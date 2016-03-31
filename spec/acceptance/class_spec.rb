require 'spec_helper_acceptance'

describe 'repoforge class' do
  let(:manifest) { 'include repoforge' }

  it 'should work without errors' do
    result = apply_manifest(manifest, :acceptable_exit_codes => [0, 2], :catch_failures => true)
    expect(result.exit_code).not_to eq 4
    expect(result.exit_code).not_to eq 6
  end

  it 'should run a second time without changes' do
    result = apply_manifest(manifest)
    expect(result.exit_code).to eq 0
  end

  %W(
    /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-dag
    /etc/pki/rpm-gpg/RPM-GPG-KEY-rpmforge-fabian
  ).each do |key|
    describe file(key) do
      it { should be_file }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
    end
  end

  describe yumrepo('rpmforge') do
    it { should exist }
    it { should be_enabled }
  end

  %w(
    rpmforge-extras
    rpmforge-testing
  ).each do |repo|
    describe yumrepo(repo) do
      it { should exist }
      it { should_not be_enabled }
    end
  end
end
