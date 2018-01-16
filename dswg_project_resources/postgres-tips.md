# Introduction
At Code for San Francisco we host a PostgreSQL server on Microsoft Azure. We host this under the Resource Group "sba" which is only because the first project to use a PostgreSQL server was the [Small Business Administration Project](https://github.com/sfbrigade/datasci-sba).

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

## Setting up a Read Only User
Setting up a Read Only User is a great/low effort way to share data with others while maintaining security of the database (more often than not we're just trying to protect ourselves from accidental writes to the DB!). Note that as of October 2017, it is not possible to automatically grant read access to all schemas and **all future schemas**, you will need to do this manually for each schema. In the example below, I am granting read only access to two schemas: `public` and `data_ingest`. If you were to add new schemas in the future you would need to `GRANT USAGE` and `GRANT SELECT ON ALL TABLES IN SCHEMA` for that particular schema.

First, follow the steps above to create a new user. In the example below, I am using `readonly` as the user.

```
-- Grant connect on database
GRANT CONNECT ON DATABASE databasename to readonly;

-- Connect to [databasename] on local database cluster
\c databasename 

-- Grant Usage to schemas
GRANT USAGE ON SCHEMA public TO readonly;
GRANT USAGE ON SCHEMA data_ingest TO readonly;

-- Grant access to future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA data_ingest GRANT SELECT ON TABLES to readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA data_ingest GRANT ALL ON TABLES TO readonly;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA data_ingest TO readonly;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA data_ingest TO readonly;
```

After creating a role, you can (optionally) create different users with the same `readonly` role. For example

```
-- Create a final user with password
CREATE USER otherreadonlyuser WITH PASSWORD 'secret';
GRANT readonly TO otherreadonlyuser;
```

Note that if you are running into issues even after running the above commands, make sure you are logged in as the user who is the owner of the particular schema. This will likely be the main user given to the project that was done by using:

```
GRANT ALL PRIVILEGES ON DATABASE datasbasename to username;
```

To list all schemas and the owners you can type `\dn` into the psql console. For example:

```
datascicongressionaldata=> \dn
             List of schemas
     Name      |          Owner
---------------+--------------------------
 data_ingest   | datascicongressionaldata
 public        | azure_superuser
 stg_analytics | datascicongressionaldata
 trg_analytics | datascicongressionaldata
(4 rows)
```

