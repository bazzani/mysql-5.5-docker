docker run --name=mysql1 -p 3306:3306 -d mysql/mysql-server:5.5


# Get the generated password
# docker logs mysql1 2>&1 | grep GENERATED

# log in to mysql again with the new password
# winpty docker exec -it mysql1 mysql -uroot -p %GENERATED password%

# Update the root user
# UPDATE mysql.user SET Password=PASSWORD('password') WHERE User='root';

# restart the container
# docker restart mysql1

# log in to mysql again with the new password
# winpty docker exec -it mysql1 mysql -uroot -ppassword
