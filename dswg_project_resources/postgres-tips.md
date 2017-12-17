# Introduction
At Code for San Francisco we host a PostgreSQL server on Microsoft Azure. We host this under the Resource Group "sba" which is only because the first project to use a PostgreSQL server was the (Small Business Administration Project)[https://github.com/sfbrigade/datasci-sba].

This doc will document some commands to make setting up new roles and databases easier.

## Creating a new Database
We recommend to spin up a new database for each project.

To create a new database, you will need to login to the server with administrator credentials. If you do not have administrator credentials please contact the current DSWG Team Leads.

After logging into the PostgreSQL server, use `\l` to view a list of all existing databases within the server

```
\l
```

Then, to create the database:

```
create database YOURDATABASENAME
```

I would suggest not using any special characters or spaces as it will be very annoying to have to escape those in the future.

## Creating a new Role
With each new project, we recommend to create a different postgres role. Each project should login to the server using their own role.

To create a new role:

```
CREATE ROLE rolename WITH LOGIN PASSWORD 'password';
```

We recommend to not use additional options (e.g. `CREATEDB`, `CREATEUSER`). Administrative access should be controlled only by the administrator account. Please talk to the Data Science Working Group team leads if you need additional priveleges.

See the (official docs)[https://www.postgresql.org/docs/9.6/static/sql-createrole.html] for more information.

## Granting Priveleges
We should have one database and one main role. Once you have set up the database and the role for the project, you will need to `GRANT ALL PRIVELEGES` for the role to the database. This will ensure that the role can do everything it needs to (e.g. write tables, read, etc.) in that specific database. To do this:

```
GRANT ALL PRIVILEGES ON DATABASE datasbasename to username;
```

