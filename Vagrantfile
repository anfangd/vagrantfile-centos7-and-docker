
Vagrant.configure("2") do |config|
  # Virtual OS
  config.vm.box = "centos/7"

  # PrivateIP
  config.vm.network "private_network", ip: "192.168.33.10"

  # Synced Folder
  config.vm.synced_folder "./", "/vargrant", type:"virtualbox"

  # Provisioning Script
  config.vm.provision :shell, :path => "provision.sh"

end
