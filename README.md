# Auth Microservice
Auth microservice from Ruby Microservices course

## Database Setup
By default Sequel assumes a PostgreSQL database, with an application specific PostgreSQL database account.  You can create this via:
```bash
$ createuser -U postgres my_app
$ createdb -U postgres -O my_app auth_microservice_production -p 5432 -h 127.0.0.1
$ createdb -U postgres -O my_app auth_microservice_test -p 5432 -h 127.0.0.1
$ createdb -U postgres -O my_app auth_microservice_development -p 5432 -h 127.0.0.1
```
Create password for user account via:
```bash
$ sudo su - postgres
$ psql -c "alter user my_app with password 'mypassword'"
```
Configure the database connection defined in .env.rb for the ENV parameter `ENV['MY_APP_DATABASE_URL'] ||= "postgres://user:password@host:port/database_name_environment"` like so:
```ruby
case ENV['RACK_ENV'] ||= 'development'
when 'test'
  ENV['AUTH_MICROSERVICE_DATABASE_URL'] ||= "postgres://my_app:mypassword@127.0.0.1:5432/auth_microservice_test"
when 'production'
  ENV['AUTH_MICROSERVICE_DATABASE_URL'] ||= "postgres://my_app:mypassword@127.0.0.1:5432/auth_microservice_production"
else
  ENV['AUTH_MICROSERVICE_DATABASE_URL'] ||= "postgres://my_app:mypassword@127.0.0.1:5432/auth_microservice_development"
end
```
According to the [Sequel documentation](https://github.com/jeremyevans/sequel#connecting-to-a-database-), you can also specify optional parameters `Settings.db` in `config/settings/*.yml` and `config/*.yml`

## Environment setup
```bash
$ bundle install
```
## Run App
Either set up configuration into `config/initializers/config.rb`, `config/settings/*.yml` and `config/*.yml` before running

```bash
$ bin/puma
$ bin/console
```
or run the application with modified configuration using environment variables
```bash
$ RACK_ENV=test ENV__PAGINATION__PAGE_SIZE=100 bin/puma
$ RACK_ENV=test ENV__PAGINATION__PAGE_SIZE=100 bin/console
```
## HTTP-requests to the app
```bash
$ curl --url "http://localhost:9292" -v
$ http :9292
```
## Run tests
```bash
$ bin/rspec
```
## Additional tips
1. Use a timestamp for the new migration filename:
```bash
$ date -u +%Y%m%d%H%M%S
```
2. After adding additional migration files, you can run the migrations:
```bash
$ rake dev_up  
$ rake test_up 
$ rake prod_up 
```
3. After modifying the migration file, you can drop down and then back up the migrations with a single command:
```bash
$ rake dev_bounce  
$ rake test_bounce 
```
4. Roll back database migration all the way down:
```bash
$ rake dev_down  
$ rake test_down 
$ rake prod_down 
```
5. Feed the database with initial data:
```bash
$ rake dev_seed
$ rake test_seed
$ rake prod_seed
```
6. The list of all tasks is called by the command:
```bash
$ bin/rake --tasks
```
7. Making a database's schema dump and [other manipulations](https://sequel.jeremyevans.net/rdoc/files/doc/bin_sequel_rdoc.html) from the command line interface
```bash
$ bin/sequel -d postgres://user:pass@host/database_name
$ bin/sequel -D postgres://user:pass@host/database_name
```
