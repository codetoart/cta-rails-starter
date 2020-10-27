# ctapad-backend

This is a Rails starter project which is used by CodeToArt team for starting any new project.
We are using following libraries 
- Ruby 2.6.6 
- Rails 6. 
- **Storage** - We are using Shrine library for SEO reason. Any object which is uploaded have following path format: `/<model>/<id>/<variable-name>/<file-name>`

It has three environments: development, staging and prod.

##Steps to use this repo
1. Git clone the project and copy the content of the folder in the new repository
2. **Recreate Master Key**
    - Delete credentials.yml.enc and master.key file
    - Regenerate above files using command `EDITOR=vi rails credentials:edit`
    - Copy contents from credentials.sample to editor displayed in above step and update the required AWS S3 keys
    - Save the credentials.yml.enc file. This will generate new master.key
    - Update the new master key in .env file
3. **Create Role in Postgres Docker**  
Docker is used for deployment in all three environments: development, staging and prod. For database, it uses Posgresql official docker image. We'll setup postgresql database now. It is defined under service `db` in `docker-compose` file.
    - Run the docker-compose db service using the command: `docker-compose run db`
    - Get the name of the container: `docker container ls`
    - Create new Role with name web and password of your choice: 
         - `docker exec -it <container-name> psql -U postgres`
         - `CREATE ROLE web WITH CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD ‘password’;`
4. **Setup Database for the environment** 
    - Change DB Name in config/database.yml for the environment you are working on
    - Change database url in credentials file for the environment you are working on
5. **Setup Storage for the environment**
    - Have local storage for development and AWS S3 storage for staging and prod
    - Setup AWS S3 for staging and prod
    - Setup AWS S3 credentials in rails credentials file
    - Cofigure Cloudfront URL for prod on AWS and Setup DNS
    - Use the Cloudfront URL for prod and update in credentials file
