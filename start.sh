#https://subscription.packtpub.com/book/web_development/9781788837682/1/ch01lvl1sec15/creating-a-docker-project-file-structure
#backup
#docker-compose exec heliosbd pg_dump -U helios helios > bkp_helios.sql

#restore / usuário-senha: root-admin
#cat bkp_helios.sql | docker-compose exec -T heliosbd psql -d helios -U helios

#docker-compose exec heliosapp python manage.py syncdb
#docker-compose exec heliosapp python manage.py migrate
docker-compose exec -u root heliosapp python manage.py compilemessages 
docker-compose exec -u root heliosapp service supervisor restart
docker-compose exec -u root heliosapp service apache2 reload
docker-compose exec -u helios heliosapp python manage.py celeryd &
#docker-compose exec heliosbd psql -U helios -d helios -a -c "ALTER TABLE auth_user ALTER COLUMN username TYPE varchar(50);"
#docker-compose exec heliosbd psql -U helios -d helios -a -c "ALTER TABLE auth_user ALTER COLUMN first_name TYPE varchar(150);"
#docker-compose exec heliosbd psql -U helios -d helios -a -c "ALTER TABLE auth_user ALTER COLUMN last_name TYPE varchar(150);"
