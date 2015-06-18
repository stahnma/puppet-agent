component "ruby" do |pkg, settings, platform|
  pkg.version "2.1.6"
  pkg.md5sum "6e5564364be085c45576787b48eeb75f"
  pkg.url "http://buildsources.delivery.puppetlabs.net/ruby-#{pkg.get_version}.tar.gz"

  pkg.replaces 'pe-ruby'
  pkg.replaces 'pe-rubygems'
  pkg.replaces 'pe-libyaml'
  pkg.replaces 'pe-libldap'
  pkg.replaces 'pe-ruby-ldap'
  pkg.replaces 'pe-rubygem-gem2rpm'

  shared='--enable-shared'
  base = 'resources/patches/ruby'
  pkg.apply_patch "#{base}/libyaml_cve-2014-9130.patch"
  pkg.apply_patch "#{base}/ruby-2.1-cve-2015-4020.patch"

  if platform.is_aix?
    pkg.apply_patch "#{base}/aix_ruby_2.1_libpath_with_opt_dir.patch"
    pkg.apply_patch "#{base}/aix_ruby_2.1_fix_proctitle.patch"
    pkg.apply_patch "#{base}/aix_ruby_2.1_fix_make_test_failure.patch"
    shared = '--disable-shared'
  end

  pkg.build_requires "openssl"

  if platform.is_deb?
    pkg.build_requires "zlib1g-dev"
  elsif platform.is_rpm?
    pkg.build_requires "zlib-devel"
  end

  pkg.configure do
     [
      "test -f '/opt/freeware/bin/granlib'  && chmod 755 /opt/freeware/bin/granlib || true",
      "./configure \
        --prefix=#{settings[:prefix]} \
        --with-opt-dir=#{settings[:prefix]} \
        #{shared} \
        --disable-install-rdoc"]
  end

  pkg.build do
    ["#{platform[:make]} -j$(shell expr $(shell #{platform[:num_cores]}) + 1)"]
  end

  pkg.install do
    ["#{platform[:make]} -j$(shell expr $(shell #{platform[:num_cores]}) + 1) install"]
  end
end
