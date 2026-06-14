# DEV_DOC.md - Developer Documentation

This document describes how to configure, build, and maintain the Inception infrastructure.

## Prerequisites
- **Target OS**: Debian Bullseye (or Alpine Linux).
- **Packages**: `docker-ce`, `docker-compose-plugin`, `make`, `git`, `curl`.
- **System Access**: Sudo rights to write to `/home/myeow/data`.

---

## Environment Setup & Secrets
1. **Host mapping**: Define the server name route inside `/etc/hosts`:
   ```text
   127.0.0.1 myeow.42.fr
   ```
2. **Environment Variables**: Configure secrets inside the `.env` file at `srcs/.env`. Make sure all WordPress usernames avoid containing "admin" or "administrator".

---

## Build and Lifecycle Commands
Manage the stack using the root `Makefile`:
* **Compile and build images**: `make` (equivalent to `make up`). This command creates the target folders `/home/myeow/data/wordpress` and `/home/myeow/data/mariadb`, builds all custom Dockerfiles, and runs the containers.
* **Stop active containers**: `make down`.
* **Prune unused build cache**: `make clean`.
* **Perform hard reset**: `make fclean` (removes all saved volume folders and databases completely).

---

## Persistent Data Directory
Data persistence is configured using local driver-based Docker volumes. The persistent data resides inside the following paths on the host system:
* **WordPress Website Files**: `/home/myeow/data/wordpress`
* **MariaDB Database Files**: `/home/myeow/data/mariadb`
