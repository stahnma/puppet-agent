component "libxml2" do |pkg, settings, platform|
  pkg.version "2.9.2"
  pkg.md5sum "9e6a9aca9d155737868b3dc5fd82f788"
  pkg.url "http://buildsources.delivery.puppetlabs.net/#{pkg.get_name}-#{pkg.get_version}.tar.gz"

  if platform.is_aix?
    pkg.build_requires "http://pl-build-tools.delivery.puppetlabs.net/aix/#{platform.os_version}/ppc/pl-gcc-5.2.0-1.aix#{platform.os_version}.ppc.rpm"
    pkg.environment "PATH" => "/opt/pl-build-tools/bin:$$PATH"
  else
    pkg.build_requires "pl-gcc"
    pkg.build_requires "make"
    pkg.environment "LDFLAGS" => "-Wl,-rpath=#{settings[:libdir]} -L#{settings[:libdir]}"
    pkg.environment "CFLAGS" => "$${CFLAGS} -fPIC"
  end


  pkg.configure do
    ["./configure --prefix=#{settings[:prefix]} --without-python"]
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
