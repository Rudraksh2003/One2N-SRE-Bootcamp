Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    
    # Forward ports for API and Nginx
    config.vm.network "forwarded_port", guest: 8080, host: 8080
    
    # Provisioning the VM to install dependencies
    config.vm.provision "shell", inline: <<-SHELL
      # Update and install dependencies
      sudo apt-get update
      sudo apt-get install -y \
        curl \
        git \
        unzip \
        vim \
        build-essential
      
      # Install Docker
      curl -fsSL https://get.docker.com -o get-docker.sh
      sudo sh get-docker.sh
      
      # Install Docker Compose
      sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
      
      # Add user to docker group
      sudo usermod -aG docker vagrant
      newgrp docker
    SHELL
  end
  