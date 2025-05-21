Vagrant.configure("2") do |config|
  # Общая базовая настройка
  config.vm.box = "bento/ubuntu-22.04"

  # Первая машина
  config.vm.define "node1" do |node1|
    node1.vm.hostname = "ubuntu-node-1"
    node1.vm.network "private_network", type: "dhcp"

    node1.vm.provider "parallels" do |v|
      v.memory = 1024
      v.cpus = 1
    end

    node1.vm.provision "shell", inline: <<-SHELL
      sudo apt update
      sudo apt install -y python3 python3-pip
    SHELL
  end

  # Вторая машина
  config.vm.define "node2" do |node2|
    node2.vm.hostname = "ubuntu-node-2"
    node2.vm.network "private_network", type: "dhcp"

    node2.vm.provider "parallels" do |v|
      v.memory = 1024
      v.cpus = 1
    end

    node2.vm.provision "shell", inline: <<-SHELL
      sudo apt update
      sudo apt install -y python3 python3-pip
    SHELL
  end
end
