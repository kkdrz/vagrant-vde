Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-20.04"
    config.vm.provision :shell, :path => "setup.sh"
    config.ssh.insert_key = true
    config.vm.synced_folder '.', '/vagrant', disabled: true

    config.vm.provider :virtualbox do |vb|
        vb.gui = true
        # Use VBoxManage to customize the VM. For example to change memory:
        vb.customize ["modifyvm", :id, "--name", "Ubuntu-20.04"]
        vb.customize ["modifyvm", :id, "--memory", "16384"]
        vb.customize ["modifyvm", :id, "--vram", 128]
        vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
        vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
        vb.customize ['modifyvm', :id, '--draganddrop', 'bidirectional']
    end
end