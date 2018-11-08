# MySql 5.5 Docker repository

## Start a mysql:5.5 container

`docker run --name=mysql1 -p 3306:3306 -d -e MYSQL_ROOT_HOST=% mysql/mysql-server:5.5`

- The container will be named _mysql1_
- `-e MYSQL_ROOT_HOST=%` will allow connections from any IP address
  - See [This stackoverflow answer](https://serverfault.com/a/831629) for more details

## Configuration

### Get the generated password

`docker logs mysql1 2>&1 | grep GENERATED`

### log in to mysql again with the new password

`docker exec -it mysql1 mysql -uroot -p%GENERATED_PASSWORD%`

### Update the root user

`UPDATE mysql.user SET Password=PASSWORD('password') WHERE User='root';`

### Restart the container

`docker restart mysql1`

### Log in to mysql again with the new password

`docker exec -it mysql1 mysql -uroot -ppassword`

