platform "el-7-x86_64" do |plat|
  plat.servicedir "/usr/lib/systemd/system"
  plat.defaultdir "/etc/sysconfig"
  plat.servicetype "systemd"

  plat.yum_repo "http://builds.puppetlabs.lan/puppet-agent/d33174cf0dfc3573aa02aa4e00e6276ed95b2549/repo_configs/rpm/pl-puppet-agent-d33174cf0dfc3573aa02aa4e00e6276ed95b2549-el-7-x86_64.repo"
  plat.provision_with "yum install --assumeyes autoconf automake createrepo rsync gcc make rpmdevtools rpm-libs yum-utils rpm-sign;echo '[pl-build-tools]\nname=pl-build-tools\ngpgcheck=0\nbaseurl=http://pl-build-tools.delivery.puppetlabs.net/yum/el/6/$basearch' > /etc/yum.repos.d/pl-build-tools.repo"
  plat.install_build_dependencies_with "yum install --assumeyes"
  plat.vcloud_name "centos-7-x86_64"
end
