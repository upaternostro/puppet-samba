require 'spec_helper_acceptance'

case fact('osfamily')
when 'RedHat'
  service_name = 'smb'
when 'Debian'
  service_name = 'smbd'
end

describe 'samba class' do
  context 'default parameters' do
    it 'should work with no errors' do
      pp = <<-EOS
    class { 'samba::server': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      expect(apply_manifest(pp, :catch_failures => true).exit_code).to be_zero
    end

    describe package('samba') do
      it { should be_installed }
    end

    describe service(service_name) do
      it { should be_enabled }
      it { should be_running }
    end

    describe 'samba::server::install' do
    end

  end
end
