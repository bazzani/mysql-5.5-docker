# MySql 5.5 Docker container

## Build a mysql5.5 Docker image
- `docker build -t mysql5.5 .`

## Start a mysql5.5 container

Run this command to start a mysql5.5 Docker container

```
docker run \
--name=mysql1 \
 -p 3306:3306 \
 -d \
 -e MYSQL_ROOT_HOST=% \
 mysql5.5`
```

| Docker argument | Description |
| --- | --- |
| `--name=mysql1` | The container will be named _mysql1_ |
| `-e MYSQL_ROOT_HOST=%` | connections will be allowed from any host, including localhost. See [This stackoverflow answer](https://serverfault.com/a/831629) for more details |

Alternatively, run the [run.sh](run.sh) bash script which contains this command.

## Configuration

1. Get the generated password
 - `docker logs mysql1 2>&1 | grep GENERATED` = $GENERATED_PASSWORD

1. Log in to mysql with the generated password
 - `docker exec -it mysql1 mysql -uroot -p$GENERATED_PASSWORD`

1. Update the root user password to _password_
 - `UPDATE mysql.user SET Password=PASSWORD('password') WHERE User='root';`

1. Restart the container
 - `docker restart mysql1`

1. Log in to mysql again with the new password (_password_)
 - `docker exec -it mysql1 mysql -uroot -ppassword`

## Case sensitivity per operating system

Database and table names __are not__ case sensitive in Windows, and case sensitive in most varieties of Unix.

### Configure the database to ignore case sensitivity on table names

The `lower_case_table_names` system variable determines if case sensitivity is enabled.  You can check the current value by running this query:
- `show variables where Variable_name='lower_case_table_names'`

There are three possible values for this:
- __0__ - lettercase specified in the CREATE TABLE or CREATE DATABASE statement. Name comparisons are case sensitive.
- __1__ - Table names are stored in lowercase on disk and name comparisons are not case sensitive.
- __2__ - lettercase specified in the CREATE TABLE or CREATE DATABASE statement, but MySQL converts them to lowercase on lookup. Name comparisons are not case sensitive.

#### Dockerfile instruction support

The Dockerfile has an instruction to copy the configuration file to the file system to enable the case insensitivity
`COPY my.cnf /etc/mysql/my.cnf`

#### Check the _lower_case_table_names_ system variable

Run this `mysqladmin` command on the docker container:
 - `docker exec mysql1 mysqladmin -uroot -ppassword variables | grep lower_case_table_names`

The result should be:
- `| lower_case_table_names | 1 |`


----

#### OPTIONAL - Manually update the configuration file

1. connect to the container `docker exec -it mysql1 bash`
1. Locate file at /etc/mysql/my.cnf
1. Edit the file by adding the following lines:

    ```
    [mysqld]
    lower_case_table_names=1
    ```
1. run `sudo /etc/init.d/mysql restart`
1. run `mysqladmin -u root -p variables | grep table` to check that `lower_case_table_names` is `1` now
