# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_BASE = "centos/7"  

# update OS and install terraform, ansible
$commonscript = <<-SCRIPT
sudo yum update -y
sudo yum install python2 epel-release git jq net-tools wget unzip -y
sudo echo "LANG=en_US.utf-8" > /etc/environment
sudo echo "LC_ALL=en_US.utf-8" >> /etc/environment
sudo yum install ansible  ansible-doc  -y 
wget  https://releases.hashicorp.com/terraform/0.12.10/terraform_0.12.10_linux_amd64.zip
unzip terraform*zip
sudo mv terraform /usr/local/bin/
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
SCRIPT

Vagrant.configure("2") do |config|
    config.vm.define "terraform_lab" do |terraform_lab|
       
         terraform_lab.vm.box = BOX_BASE
        
         # Memory and CPU allocation
         terraform_lab.vm.provider "virtualbox" do |v|
            v.memory = 2048
            v.cpus = 2
         end
        
         # Host name allocation
         terraform_lab.vm.hostname = "terraformlab.example.com"

         # Installing required packages for docker  node
        terraform_lab.vm.provision "shell", inline: $commonscript
    end
end
