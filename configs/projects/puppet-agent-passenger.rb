project "puppet-agent-passenger" do |proj|
  # Project level settings our components will care about
  proj.setting(:prefix, "/opt/puppetlabs/puppet")
  proj.setting(:sysconfdir, "/etc/puppetlabs")
  proj.setting(:puppet_configdir, File.join(proj.sysconfdir, 'puppet'))
  proj.setting(:puppet_codedir, "/etc/puppetlabs/code")
  proj.setting(:logdir, "/var/log/puppetlabs")
  proj.setting(:piddir, "/var/run/puppetlabs")
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

  # Platform specific
  proj.setting(:cflags, "-I#{proj.includedir}")
  proj.setting(:ldflags, "-L#{proj.libdir} -Wl,-rpath=#{proj.libdir}")

  # First our stuff
  proj.component "rubygem-rack"
  proj.component "rubygem-passenger"

  proj.directory proj.prefix
  proj.directory proj.sysconfdir
  proj.directory proj.logdir
  proj.directory proj.piddir
  proj.directory proj.link_bindir

end
