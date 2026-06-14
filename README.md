_This project has been created as part of the 42 curriculum by shatan._

# Inception - System Administration with Docker

A comprehensive system administration project focused on virtualizing a multi-container LEMP-like stack securely using Docker, Docker Compose, and custom built base images (Debian Bullseye).

---

## Description

The goal of this project is to set up a small, secure, containerized web infrastructure using Docker and Docker Compose. Each service runs in its own dedicated container and communicates over a private virtual bridge network. No pre-built application images from Docker Hub were used (except for the bare Debian Bullseye operating system). All service images were built from scratch using custom `Dockerfiles`.

### Architecture Overview
- **NGINX**: The single entrypoint to the stack, accepting requests on port `443` only, secured with self-signed SSL/TLS (v1.3 protocol).
- **WordPress**: Running with `php-fpm` on port `9000` to process PHP scripts and serve the content.
- **MariaDB**: The relational database management system storing all site information on port `3306`.
- **Redis (Bonus)**: Caching WordPress database queries to decrease loading times.
- **FTP Server (Bonus)**: A vsftpd daemon to access and manage WordPress media/files directly.
- **Adminer (Bonus)**: A single-file database management system accessible on port `600`.
- **Static Website (Bonus)**: A simple Node.js website serving a portfolio/showcase page on port `3000`.
- **cAdvisor (Bonus)**: Google's monitoring tool listening on port `8080` to collect real-time container metrics.

---

## Technical Comparisons

### ◦ Virtual Machines vs Docker
* **Architecture**: Virtual Machines (VMs) virtualize physical hardware via a Hypervisor, meaning each VM runs a full guest operating system (kernel, drivers, utilities). Docker virtualizes the operating system level, sharing the host machine's kernel and isolating user spaces using kernel namespaces and control groups (cgroups).
* **Resource Usage**: VMs consume gigabytes of storage and require dedicated allocations of RAM and CPU. Docker containers are extremely lightweight, sharing host resources dynamically and utilizing images that are often only tens of megabytes.
* **Boot Time**: VMs require minutes to load a full OS kernel. Docker containers start in seconds since they run as isolated processes on the already running host kernel.

### ◦ Secrets vs Environment Variables
* **Security**: Environment variables are stored in plain text in process memory and can easily leak via command-line monitoring (`ps aux`), build history, or logs. Secrets are encrypted at rest and in transit, and are only mounted as in-memory files (usually under `/run/secrets/`) inside authorized containers at runtime.
* **Lifecycle**: Environment variables are static configurations defined in `.env` files or Dockerfiles. Secrets are managed dynamically by the orchestrator and can be updated without rebuilding the container.

### ◦ Docker Network vs Host Network
* **Docker Network**: Creates an isolated virtual bridge network. Containers are assigned private IPs and can communicate using internal DNS hostnames (e.g., `wordpress` connecting to `mariadb`). External ports are closed unless explicitly published.
* **Host Network**: Removes the isolation layer. The container shares the host's network namespace directly, binding ports directly to the host IP. If a container binds to port `80`, it occupies port `80` on the actual host machine, increasing vulnerability and causing port conflicts.

### ◦ Docker Volumes vs Bind Mounts
* **Docker Volumes**: Managed directly by Docker in a dedicated directory on the host (e.g., `/var/lib/docker/volumes/`). They are isolated from host user modifications, safer for permissions, and easily managed via the Docker CLI.
* **Bind Mounts**: A direct connection between a folder on the host machine and a path inside the container. They rely on the host's directory structure and can cause permission conflicts if the host and container users mismatch.

---

## Instructions

### Prerequisites
- Debian 11/12 or Alpine Linux host environment.
- Docker Engine and Docker Compose (v2) installed.
- Sudo/Root permissions to create directories in `/home/shatan/data`.

### Execution
1. Update your local hosts file on both the VM and Windows host to map `shatan.42.fr` to `127.0.0.1`.
2. Clean and run the build:
   ```bash
   make
   ```
3. Stop the stack:
   ```bash
   make down
   ```
4. Perform a complete cleanup (deleting volumes and system cache):
   ```bash
   make fclean
   ```

---

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [WordPress CLI Command Reference](https://developer.wordpress.org/cli/commands/)
- [OpenSSL Certificate Creation Guide](https://www.openssl.org/)
- [vsftpd Configuration Documentation](https://security.appspot.com/vsftpd/vsftpd.conf.html)
