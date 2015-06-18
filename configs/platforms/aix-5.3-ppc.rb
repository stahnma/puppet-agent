platform "aix-53-power" do |plat|
  plat.servicedir "/etc/init.d"
  plat.defaultdir "/etc/sysconfig"
  plat.servicetype "sysv"

#  plat.zypper_repo "http://pl-build-tools.delivery.puppetlabs.net/yum/sles/10/i386/pl-build-tools-sles-10-i386.repo"
#  plat.provision_with "zypper -n --no-gpg-checks install -y aaa_base autoconf automake rsync gcc make"
#  plat.install_build_dependencies_with "zypper -n --no-gpg-checks install -y"
#  plat.vcloud_name "sles-10-i386"
end
