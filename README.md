# MySql 5.5 Docker container

## Start a mysql:5.5 container

Run this command to start a mysql 5.5 Docker container

```
docker run \
--name=mysql1 \
 -p 3306:3306 \
 -d \
 -e MYSQL_ROOT_HOST=% \
 mysql/mysql-server:5.5`
```

| Docker argument | Description |
| --- | --- |
| `--name=mysql1` | The container will be named _mysql1_ |
| `-e MYSQL_ROOT_HOST=%` | connections will be allowed from any host, including localhost. See [This stackoverflow answer](https://serverfault.com/a/831629) for more details |

Alternatively, run the [run.sh](run.sh) bash script which contains this command.

## Configuration

### Get the generated password

`docker logs mysql1 2>&1 | grep GENERATED`

### Log in to mysql with the generated password

`docker exec -it mysql1 mysql -uroot -p%GENERATED_PASSWORD%`

### Update the root user password to _password_

`UPDATE mysql.user SET Password=PASSWORD('password') WHERE User='root';`

### Restart the container

`docker restart mysql1`

### Log in to mysql again with the new password (_password_)

`docker exec -it mysql1 mysql -uroot -ppassword`

