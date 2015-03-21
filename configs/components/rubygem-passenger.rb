component "passenger" do |pkg, settings, platform|
  gemname = pkg.get_name.gsub('rubygem-', '')
  pkg.version "5.0.4"
  pkg.md5sum "882996ab5d8169e3ab8f48822917bc16"
  pkg.url "http://buildsources.delivery.puppetlabs.net/#{gemname}-#{pkg.get_version}.gem"

  pkg.build_requires "puppet-agent"
  if platform.is_el?
    pkg.build_requires "httpd-devel"
    pkg.build_requires "openssl-devel"
    pkg.build_requires "curl-devel"
    pkg.build_requires "gcc-c++"
    pkg.requires "httpd"
    pkg.requires "mod_ssl"
    apache_conf_dir = '/etc/httpd/conf.d'
    apache_conf_file = 'puppet-passenger.conf'
  else
    pkg.build_requires "apache2-dev"
    pkg.build_requires "apache2-mpm-worker"
    pkg.build_requires "libcurl4-openssl-dev"
    pkg.build_requires "libssl-dev"
    pkg.requires "apache2"
    apache_conf_dir = '/etc/apache2/sites-available'
    apache_conf_file = 'puppet-passenger'
  end


  pkg.install do
    [
    "#{settings[:bindir]}/gem install --no-rdoc --no-ri --local #{gemname}-#{pkg.get_version}.gem",
    "/opt/puppetlabs/puppet/bin/passenger-install-apache2-module --languages ruby -a",
    "rm -rf /opt/puppetlabs/puppet/lib/ruby/gems/2.1.0/gems/#{gemname}-#{pkg.get_version}/helper-scripts/wsgi-loader.py /opt/puppetlabs/puppet/lib/ruby/gems/2.1.0/gems/#{gemname}-#{pkg.get_version}/test/stub/wsgi/passenger_wsgi.py /opt/puppetlabs/puppet/lib/ruby/gems/2.1.0/gems/#{gemname}-#{pkg.get_version}/doc",
    "mkdir -p /opt/puppetlabs/server/data/puppetmaster/public",
    "mkdir -p #{apache_conf_dir}"
    ]
  end
  pkg.install_file './config.ru', '/opt/puppetlabs/server/data/puppetmaster/config.ru', owner: 'puppet', group: 'puppet'
  pkg.install_configfile './passenger-apache.conf', "#{apache_conf_dir}/#{apache_conf_file}"
end
