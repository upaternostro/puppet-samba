require 'spec_helper'

describe 'samba::winbind' do

  context 'winbind server management' do

    let :facts do
      {
        :osfamily       => 'RedHat',
        :concat_basedir => '/dne',
      }
    end

    it { should contain_class("samba::params") }

    it { should contain_class("samba::winbind::install") }

    it { should contain_package('winbind').with(
      :ensure => 'present'
    )}

    # winbind service
    it { should contain_class("samba::winbind::service") }

    it { should contain_service('winbind').with(
      :ensure => 'running'
    )}

  end
end
