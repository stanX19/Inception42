# USER_DOC.md - User Documentation

This guide provides simple instructions on how to use and verify the containerized services in the Inception stack.

## Services Included
The following services are configured and running:
* **Web Portal (WordPress)**: A complete content management system accessible via HTTPS.
* **Database Manager (Adminer)**: A clean visual interface to manage your database.
* **Showcase Website**: A fast, static portfolio site.
* **cAdvisor Dashboard**: A real-time system resources monitor.
* **FTP Access (vsftpd)**: A standard file transfer service.

---

## Startup and Shutdown
To control the system administration stack:
1. **Start the Stack**:
   ```bash
   make
   ```
2. **Stop the Stack**:
   ```bash
   make down
   ```

---

## Accessing the Web Services
Open your web browser and navigate to the following links:
* **WordPress Homepage**: `https://shatan.42.fr`
* **Adminer Login**: `http://shatan.42.fr:600`
* **Static Page**: `http://shatan.42.fr:3000`
* **cAdvisor Metrics**: `http://shatan.42.fr:8080`

---

## Managing Credentials
All administrative passwords, database names, and user accounts are stored locally in the environment secrets file:
* **Environment variables file**: Located at `/home/shatan/Inception/srcs/.env` on the host machine.
* **Admin Credentials**:
  * WordPress Admin User: `wp_owner`
  * WordPress Admin Password: `password`
  * Database Root User Password: `password`

---

## Service Status Verification
To verify that all services are running correctly, execute this command on the host machine:
```bash
docker ps
```
All containers should display a status of `Up` and list their mapped ports.
