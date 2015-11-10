component "libxslt" do |pkg, settings, platform|
  pkg.version "1.1.28"
  pkg.md5sum "9667bf6f9310b957254fdcf6596600b7"
  pkg.url "http://buildsources.delivery.puppetlabs.net/#{pkg.get_name}-#{pkg.get_version}.tar.gz"

  pkg.build_requires "libxml2"
  
  if platform.is_aix?
    pkg.build_requires "http://pl-build-tools.delivery.puppetlabs.net/aix/#{platform.os_version}/ppc/pl-gcc-5.2.0-1.aix#{platform.os_version}.ppc.rpm"
    pkg.environment "PATH" => "/opt/pl-build-tools/bin:$$PATH"
  elsif platform.is_solaris?
    pkg.environment "PATH" => "/opt/pl-build-tools/bin:$$PATH:/usr/local/bin:/usr/ccs/bin:/usr/sfw/bin:#{settings[:bindir]}"
    pkg.environment "CFLAGS" => settings[:cflags]
    pkg.environment "LDFLAGS" => settings[:ldflags]
    # Configure on Solaris incorrectly passes flags to ld
    pkg.apply_patch 'resources/patches/libxslt/disable-version-script.patch'
  else
    pkg.build_requires "pl-gcc"
    pkg.build_requires "make"
    pkg.environment "LDFLAGS" => "-Wl,-rpath=#{settings[:libdir]} -L#{settings[:libdir]}"
    pkg.environment "CFLAGS" => "$${CFLAGS} -fPIC"
  end

  if platform.name =~ /solaris-11/
    pkg.build_requires "pl-gcc-#{platform.architecture}"
  end

  pkg.configure do
    ["./configure --prefix=#{settings[:prefix]} --with-libxml-prefix=#{settings[:prefix]}"]
  end

  pkg.build do
    ["#{platform[:make]} VERBOSE=1 -j$(shell expr $(shell #{platform[:num_cores]}) + 1)"]
  end

  pkg.install do
    [
     "#{platform[:make]} VERBOSE=1 -j$(shell expr $(shell #{platform[:num_cores]}) + 1) install",
     "rm -rf #{settings[:datadir]}/gtk-doc",
     "rm -rf #{settings[:datadir]}/doc",
     "rm -rf #{settings[:datadir]}/man"
    ]
  end

end
