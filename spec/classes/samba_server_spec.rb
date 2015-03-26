require 'spec_helper_acceptance'

describe 'samba::server' do

  context 'samba server management' do

    let :facts do
      {
        :osfamily       => 'RedHat',
        :concat_basedir => '/dne',
      }
    end

    it { should contain_class('samba::params') }
    it { should contain_class('samba::server::install') }

    it { should contain_package('samba').with(
      :ensure => 'present'
    )}

    # samba service
    it { should contain_class('samba::server::service') }

    it { should contain_service('samba').with(
      :ensure => 'running'
    )}

    # samba configuration file
    it { should contain_class('samba::server::config') }
    it do
      should contain_file('/etc/samba/smb.conf').with({
        'ensure' => 'present',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
    end
  end

end
