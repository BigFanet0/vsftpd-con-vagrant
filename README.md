# Servidor FTP con vsftpd, MariaDB y Vagrant

Este repositorio contiene la infraestructura como código (IaC) para desplegar un servidor FTP seguro y una base de datos MariaDB utilizando Vagrant.

## Características

- **Virtualización**: Vagrant con Vbox.
- **Servidor FTP**: vsftpd 
  - Conexiones anónimas deshabilitadas.
  - Modo Pasivo.
  - Autenticación mediante usuarios virtuales en MariaDB (MySQL).
  - Enjaulamiento de usuarios.
  - FTPS Forzado.
- **Base de Datos**: MariaDB.
- **Firewall**: UFW configurado.

## Requisitos

- Vagrant
- VirtualBox
- Plugin `vagrant-vbguest` (opcional, recomendado)

## Estructura del Proyecto

```
.
├── Vagrantfile            
├── conf/
│   ├── pam_vsftpd          
│   └── vsftpd.conf        
└
├── script_mariadb.sh    
└── script_ftp.sh   
```

## Instalación y Despliegue

1. Descarga los archivos.
2. En la raíz del directorio, ejecuta:

```bash
vagrant up
```

Esto levantará dos máquinas virtuales:

- **bd** (192.168.56.10): Servidor de Base de Datos.
- **ftp** (192.168.56.11): Servidor FTP.

## Prueba de Conexión

Una vez finalizado el despliegue, puedes conectar usando un cliente FTP (como FileZilla) con los siguientes datos:

- **Host**: `192.168.56.11`
- **Usuario**: `alvaro`
- **Contraseña**: `alvaro123`

Puedes crear un usuario a tu gusto.

**Nota**: Al ser un certificado autofirmado, deberás aceptar la advertencia de seguridad en tu cliente FTP.

## Detalles de Implementación Automatizada

### Base de Datos

- Se crea la BD `vsftpd` y la tabla `users`.
- Usuario de prueba insertado automáticamente.
- Se habilita el acceso remoto para el usuario `alvaro`.

### Servidor FTP

- Se instala `vsftpd` y `libpam-mysql`.
- Se genera un certificado SSL automáticamente en `/etc/ssl/private/vsftpd.pem`.
- Se configura PAM para consultar la base de datos remota en `192.168.56.10`.
- Se configuran reglas de firewall con `ufw` para puertos 20, 21, 990 y rango pasivo.

## Comprobaciones

<img width="1718" height="673" alt="Captura desde 2025-12-11 20-28-07" src="https://github.com/user-attachments/assets/7801b19b-e1bd-4494-91c4-bd16b10d4e6c" />

<img width="1718" height="813" alt="imagen" src="https://github.com/user-attachments/assets/89ee7c3c-eca7-4827-9f04-084e4e9a7de5" />

