component 'icu' do |pkg, settings, platform|
  pkg.version '54.1'
  pkg.md5sum 'e844caed8f2ca24c088505b0d6271bc0'
  pkg.url "http://buildsources.delivery.puppetlabs.net/icu4c-54_1-src.tgz"

  pkg.environment "PATH" => "/opt/pl-build-tools/bin:$$PATH"

  if platform.is_solaris?
    pkg.environment "CC" => "/opt/pl-build-tools/bin/#{settings[:platform_triple]}-gcc"
  elsif platform.is_aix?
    pkg.environment "CC" => "/opt/pl-build-tools/bin/gcc"
    pkg.environment "LDFLAGS" => settings[:ldflags]
  end

  pkg.configure do
    "bash configure --enable-shared --prefix=#{settings[:prefix]} #{settings[:host]}"
  end

  pkg.build do
    "#{platform[:make]} -j$(shell expr $(shell #{platform[:num_cores]}) + 1)"
  end

  pkg.install do
    "#{platform[:make]} -j$(shell expr $(shell #{platform[:num_cores]}) + 1) install"
  end

end
