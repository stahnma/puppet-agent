component "passenger" do |pkg, settings, platform|
  gemname = pkg.get_name.gsub('rubygem-', '')
  pkg.version "5.0.2"
  pkg.md5sum "a31a476c28fedb7842699a0256d7dc32"
  pkg.url "http://buildsources.delivery.puppetlabs.net/#{gemname}-#{pkg.get_version}.gem"

  pkg.build_requires "puppet-agent"
  pkg.build_requires "httpd-devel"
  pkg.build_requires "openssl-devel"
  pkg.build_requires "curl-devel"
  pkg.build_requires "gcc-c++"

  pkg.install do
    [
    "#{settings[:bindir]}/gem install --no-rdoc --no-ri --local #{gemname}-#{pkg.get_version}.gem",
    "/opt/puppetlabs/puppet/bin/passenger-install-apache2-module -a"
    ]
  end
end
