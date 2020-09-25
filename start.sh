docker-compose exec heliosapp python manage.py syncdb
docker-compose exec heliosapp python manage.py migrate
docker-compose exec -u root heliosapp python manage.py compilemessages 
docker-compose exec heliosbd psql -U helios -d helios -a -c "ALTER TABLE auth_user ALTER COLUMN username TYPE varchar(50);"
docker-compose exec heliosbd psql -U helios -d helios -a -c "ALTER TABLE auth_user ALTER COLUMN firts_name TYPE varchar(100);"
docker-compose exec heliosbd psql -U helios -d helios -a -c "ALTER TABLE auth_user ALTER COLUMN last_name TYPE varchar(100);"
