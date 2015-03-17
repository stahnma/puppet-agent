project "puppet-agent-passenger" do |proj|
  # Project level settings our components will care about
  proj.setting(:prefix, "/opt/puppetlabs/puppet")
  proj.setting(:sysconfdir, "/etc/puppetlabs")
  proj.setting(:puppet_configdir, File.join(proj.sysconfdir, 'puppet'))
  proj.setting(:puppet_codedir, "/etc/puppetlabs/code")
  proj.setting(:logdir, "/var/log/puppetlabs/puppetmaster")
  proj.setting(:piddir, "/var/run/puppetlabs/puppetmaster")
  proj.setting(:bindir, File.join(proj.prefix, "bin"))
  proj.setting(:link_bindir, "/opt/puppetlabs/bin")
  proj.setting(:libdir, File.join(proj.prefix, "lib"))
  proj.setting(:includedir, File.join(proj.prefix, "include"))
  proj.setting(:datadir, File.join(proj.prefix, "share"))
  proj.setting(:mandir, File.join(proj.datadir, "man"))
  proj.setting(:ruby_vendordir, File.join(proj.libdir, "ruby", "vendor_ruby"))

  proj.description "A passenger package add on for puppet-agent for those who still need a ruby server."
  proj.version_from_git
  proj.license "ASL 2.0"
  proj.vendor "Puppet Labs <info@puppetlabs.com>"
  proj.homepage "https://www.puppetlabs.com"

  proj.requires "puppet-agent"
  proj.requires "httpd"
  proj.requires "openssl"
  proj.requires "mod_ssl"



  proj.user('puppet', is_system: true , homedir: '/opt/puppetlabs/server/data/puppetmaster')

  # Platform specific
  proj.setting(:cflags, "-I#{proj.includedir}")
  proj.setting(:ldflags, "-L#{proj.libdir} -Wl,-rpath=#{proj.libdir}")

  # First our stuff
  proj.component 'configru'
  proj.component 'passenger-apache-conf'
  proj.component "rubygem-rack"
  proj.component "rubygem-passenger"

  proj.directory proj.prefix
  proj.directory "/etc/httpd/conf.d/"
  proj.directory "/opt/puppetlabs/server/data/puppetmaster" , owner: 'puppet', group: 'puppet'
  proj.directory proj.logdir

end
