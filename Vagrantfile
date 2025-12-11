Vagrant.configure("2") do |config|
  config.vm.box = "jcpetro97/debian13"
  config.vm.define "bd" do |bd|
    bd.vm.hostname = "bd"
    bd.vm.network "private_network", ip: "192.168.56.10"
    bd.vm.provision "shell", path:"script_mariadb.sh"
  end
  config.vm.define "ftp" do |ftp|
    ftp.vm.hostname = "ftp"
    ftp.vm.network "private_network", ip: "192.168.56.11"
    ftp.vm.provision "file", source: "conf/vsftpd.conf", destination: "/tmp/vsftpd.conf"
    ftp.vm.provision "file", source: "conf/pam_vsftpd", destination: "/tmp/pam_vsftpd"
    ftp.vm.provision "shell", path:"script_ftp.sh"
  end
end
