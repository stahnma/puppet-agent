component "rubygem-rack" do |pkg, settings, platform|
  gemname = pkg.get_name.gsub('rubygem-', '')
  # This component is used for the passenger package
  pkg.version "1.6.0"
  pkg.md5sum "9c1281dd0c486b931a52445a703a4eaa"
  pkg.url "http://buildsources.delivery.puppetlabs.net/#{gemname}-#{pkg.get_version}.gem"

  pkg.build_requires "puppet-agent"

  pkg.install do
    ["#{settings[:bindir]}/gem install --no-rdoc --no-ri --local #{gemname}-#{pkg.get_version}.gem"]
  end
end
