#https://subscription.packtpub.com/book/web_development/9781788837682/1/ch01lvl1sec15/creating-a-docker-project-file-structure
cp conf/settings.py helios-server/settings.py
docker-compose exec heliosapp python manage.py syncdb
docker-compose exec heliosapp python manage.py migrate
docker-compose exec -u root heliosapp python manage.py compilemessages 
docker-compose exec -u root heliosapp service supervisor restart
docker-compose exec -u root heliosapp service apache2 reload
docker-compose exec -u helios heliosapp python manage.py celeryd &
docker-compose exec heliosbd psql -U helios -d helios -a -c "ALTER TABLE auth_user ALTER COLUMN username TYPE varchar(50);"
docker-compose exec heliosbd psql -U helios -d helios -a -c "ALTER TABLE auth_user ALTER COLUMN first_name TYPE varchar(150);"
docker-compose exec heliosbd psql -U helios -d helios -a -c "ALTER TABLE auth_user ALTER COLUMN last_name TYPE varchar(150);"
