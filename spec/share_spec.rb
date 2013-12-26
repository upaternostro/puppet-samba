require 'spec_helper'

describe 'samba::server::share' do
  let(:title) { 'test_share' }
  it { should_include_class('samba::server') }
  it { should_include_class('samba::params') }

  it do
    should_contain_file('/etc/samba/smb.conf').with({
      'ensure' => 'present',
      'owner' => 'root',
      'group' => 'root',
      'mode' => '0644',
    })
  end
end
