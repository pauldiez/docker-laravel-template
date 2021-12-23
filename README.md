# How to Start a New Project

## Prerequisites
- docker
- docker-compose


## Installation

1. CD into project root dir
```bash
cd [project folder]
```

2. Startup Servers

```bash
docker-compose up -d

# if you want shutdown server, run this command
docker-compose down -v
```

3. Shell into docker PHP service
```bash
docker exec -ti php /bin/bash
```

4. Installed PHP Laravel framework

```bash
cd /var/www/[project folder]
composer update
```

5. Set Appropriate Permissions

```bash
chown -R :www-data /var/www/project.com/storage/
chown -R :www-data /var/www/project.com/bootstrap/cache/
chmod -R 0777 /var/www/project.com/storage/
chmod -R 0775 /var/www/project.com/bootstrap/cache/
```

6. Test Website

   - [http://localhost](http://localhost)


7. Migrate database schema

```bash
php artisan migrate
```

8. Seed database schema

```bash
php artisan db:seed
```

9. Test Database Connection

   [http://localhost/api/test-db-connection](http://localhost/api/test-db-connection)


10. Ready for Development!




##Additional Development Instructions


###Create a Database Table

####Migrations

```bash
# First, we create a migration file ()
cd /var/www/project.com
php artisan make:migration  create_blog_post_table --create=blog_post

# Second, open the migration create_blog_post_table file in the migration folder (src/project.com/database/migrations)
# Third, edit the up file to add the table schema (see instruction: https://laravel.com/docs/8.x/migrations#migration-structure)
# Forth, run the migration (implement the db scheme into the database)
php artisan migrate 
```

####Models
```bash
#Fifth, if you need an ORM model for the table, we create a model file
php artisan make:model BlogPost

# Sixth, open the model file (BlogPost.php) in the model folder (src/project.com/app/Models)
# Finally, edit the model file accordingly (see instruction: https://laravel.com/docs/8.x/eloquent#eloquent-model-conventions)
```





