# ForeverNew-M2-Docker
Docker Build for ForeverNew M2 Cloud on NGINX

## Requirements
1. Install Docker for your OS (https://www.docker.com/)
1. Install Docker-Sync (http://docker-sync.io/)
1. Add m2.dev to your host file (/etc/hosts)
1. Clone this repo
1. Ensure there is a folder on the same level magento2 (this is configured in `docker-sync.yml`)
1. Make sure File Sharing for that folder is configured (information below)
1. For Mac, change `sync_strategy` in `docker-sync.yml` to `native_osx`

## Start development environment:
1. From the project root, run `sh dev-env-start.sh`
2. Access the website on your browser at https://m2.dev
3. Import database dump. If you don't have one run the following command inside the container:

```./bin/magento setup:install --admin-user 'admin' --admin-password 'Password123' --admin-email 'william@aligent.com.au' --admin-firstname 'William' --admin-lastname 'Tran' --base-url 'http://m2.dev' --base-url-secure 'https://m2.dev'```

## Useful commands:
- Access the web container `docker-compose exec web bash` or `./ssh-web.sh`
- PHPCLI-DEBUG: from inside the container, call `phpcli-debug`
