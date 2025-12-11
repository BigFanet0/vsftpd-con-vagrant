!/bin/bash
sudo apt-get update -
sudo apt-get install -y mariadb-server

#Permitimos las conexiones remotas.
sudo sed -i "s/bind-address\s*=.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb

#Configuramos la base de datos.
sudo mysql <<EOF
CREATE DATABASE IF NOT EXISTS vsftpd;
USE vsftpd;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    pass VARCHAR(50) NOT NULL
);

INSERT INTO users (name, pass) VALUES ('alvaro', 'alvaro123');
CREATE USER IF NOT EXISTS 'alvaro'@'192.168.56.11' IDENTIFIED BY 'alvaro123';
GRANT SELECT ON vsftpd.* TO 'alvaro'@'192.168.56.11';
FLUSH PRIVILEGES;
EOF

