source 'https://rubygems.org'

group :development, :test do
  gem 'rake',                    :require => false
  gem 'rspec-puppet',            :require => false
  gem 'puppetlabs_spec_helper',  :require => false
  gem 'puppet-lint',             :require => false
  gem 'beaker', :git => 'git@github.com:puppetlabs/beaker.git', :branch => 'master'
  gem 'beaker-rspec', :git => 'git@github.com:puppetlabs/beaker-rspec.git', :branch => 'master'
  #gem 'serverspec',              :require => false
  gem 'docker-api',              :require => false
  gem 'rspec', '~> 3.1'
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

# vim:ft=ruby
