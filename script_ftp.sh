/bin/bash
echo "Updating apt cache..."
sudo apt-get update -y
sudo apt-get install -y vsftpd libpam-mysql ufw

#Generamos certificado SSL.
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/vsftpd.pem \
    -out /etc/ssl/private/vsftpd.pem \
    -subj "/C=ES/ST=Madrid/L=Madrid/O=IT/CN=ftp.example.com"

sudo mv /tmp/vsftpd.conf /etc/vsftpd.conf
sudo chown root:root /etc/vsftpd.conf
sudo chmod 644 /etc/vsftpd.conf
sudo mv /tmp/pam_vsftpd /etc/pam.d/vsftpd_mysql
sudo chown root:root /etc/pam.d/vsftpd_mysql

#Creamos el usuario.
if ! id "alvaro" &>/dev/null; then
    sudo useradd --home /home/alvaro --gid nogroup -m --shell /bin/false alvaro
fi

sudo mkdir -p /home/alvaro/alvaro
sudo chown alvaro:nogroup /home/alvaro/alvaro
sudo chmod 755 /home/alvaro/alvaro
sudo chmod 775 /home/alvaro/alvaro

#Configuramos el firewall.
sudo ufw allow 20/tcp
sudo ufw allow 21/tcp
sudo ufw allow 990/tcp
sudo ufw allow 60000:60100/tcp
sudo ufw allow 22/tcp
sudo ufw --force enable

sudo systemctl restart vsftpd
