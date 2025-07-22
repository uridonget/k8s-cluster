# -*- mode: ruby -*-
# vi: set ft=ruby :

N = ENV.fetch('VAGRANT_VM_COUNT', 3).to_i

PUBLIC_KEY_PATH = File.expand_path("~/.ssh/k8s-key.pub")

$publicKey = File.read(PUBLIC_KEY_PATH)

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2204"
  config.vm.box_check_update = false

  (1..N).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.hostname = "node-#{i}"
      node.vm.network "private_network", ip: "192.168.56.#{100 + i}"

      node.vm.provision "shell", inline: <<-SHELL
        if ! id -u ubuntu >/dev/null 2>&1; then
          useradd -m -s /bin/bash ubuntu
          usermod -aG sudo ubuntu
          echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu
        fi

        mkdir -p /home/ubuntu/.ssh
        touch /home/ubuntu/.ssh/authorized_keys
        grep -q -F "#{$publicKey}" /home/ubuntu/.ssh/authorized_keys || echo "#{$publicKey}" >> /home/ubuntu/.ssh/authorized_keys
        chown -R ubuntu:ubuntu /home/ubuntu/.ssh
        chmod 700 /home/ubuntu/.ssh
        chmod 600 /home/ubuntu/.ssh/authorized_keys
      SHELL
    end
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = "2"
  end
end
