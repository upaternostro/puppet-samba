require 'spec_helper'

describe 'samba' do

  context 'when server_manage is true' do

    let :facts do
      {
        :osfamily       => 'RedHat',
        :concat_basedir => '/dne',
      }
    end
    it { should contain_class("samba::params") }

    let :params do
      { :server_manage => true }
    end

    it { should contain_class("samba::server::install") }

    it { should contain_package('samba').with(
      :ensure => 'present'
    )}

    # samba service
    it { should contain_class("samba::server::service") }

    it { should contain_service('samba').with(
      :ensure => 'running'
    )}

  end

end
