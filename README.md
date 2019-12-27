# Matomo DB Schema

## Running

```sh
docker run -d \
  $(echo "$DOCKER_RUN_OPTS") \
  -h matomo-mysql \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_USER=matomo \
  -e MYSQL_PASSWORD=matomo \
  -e MYSQL_DATABASE=matomo \
  -v matomo-mysql-data:/var/lib/mysql \
  -p 3306:3306 \
  --name matomo-mysql \
  --restart always \
  docker.io/library/mysql:5.7
```

```sh
docker exec -i matomo-mysql /bin/sh << 'EOSHELL'
cat << 'EOF' > /etc/mysql/conf.d/increase.cnf
[mysqld]
max_allowed_packet = 128M

EOF
EOSHELL
```

```sh
docker restart matomo-mysql
```

```sh
docker run -d \
  $(echo "$DOCKER_RUN_OPTS") \
  -h matomo \
  -e MATOMO_DATABASE_HOST=matomo-mysql \
  -e MATOMO_DATABASE_ADAPTER=MYSQLI \
  -e MATOMO_DATABASE_TABLES_PREFIX=matomo_ \
  -e MATOMO_DATABASE_USERNAME=matomo \
  -e MATOMO_DATABASE_PASSWORD=matomo \
  -e MATOMO_DATABASE_DBNAME=matomo \
  -v matomo-data:/var/www/html \
  -p 8080:80 \
  --name matomo \
  --restart always \
  --link matomo-mysql \
  docker.io/library/matomo:3.13.0-apache
```

```sh
echo -e '[INFO]\thttp://127.0.0.1:8080'
```

## SchemaSpy

```sh
# Install Dependencies
npm install

# Build SchemaSpy
npm run build

# HTTP Serve
npm run serve
npm run stop

# Deploy GitHub Pages
npm run deploy
```
