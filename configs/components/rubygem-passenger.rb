component "passenger" do |pkg, settings, platform|
  gemname = pkg.get_name.gsub('rubygem-', '')
  pkg.version "5.0.4"
  pkg.md5sum "882996ab5d8169e3ab8f48822917bc16"
  pkg.url "http://buildsources.delivery.puppetlabs.net/#{gemname}-#{pkg.get_version}.gem"

  pkg.build_requires "puppet-agent"
  pkg.build_requires "httpd-devel"
  pkg.build_requires "openssl-devel"
  pkg.build_requires "curl-devel"
  pkg.build_requires "gcc-c++"

  pkg.install do
    [
    "#{settings[:bindir]}/gem install --no-rdoc --no-ri --local #{gemname}-#{pkg.get_version}.gem",
    "/opt/puppetlabs/puppet/bin/passenger-install-apache2-module --languages ruby -a",
    "rm -f /opt/puppetlabs/puppet/lib/ruby/gems/2.1.0/gems/passenger-5.0.2/helper-scripts/wsgi-loader.py /opt/puppetlabs/puppet/lib/ruby/gems/2.1.0/gems/passenger-5.0.2/test/stub/wsgi/passenger_wsgi.py",
    "curl -O http://buildsources.delivery.puppetlabs.net/passenger-apache-conf",
    "mv passenger-apache-conf /etc/httpd/conf.d/passenger.conf",
    "mkdir -p /opt/puppetlabs/server/data/puppetmaster/public",
    "pushd /opt/puppetlabs/server/data/puppetmaster/public",
    "curl -O https://raw.githubusercontent.com/puppetlabs/puppet/master/ext/rack/config.ru",
    "popd"

    ]
  end
end
