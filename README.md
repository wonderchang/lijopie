# lijopie

## Build

* Create database and import the database structure

        $ mysql -u username -p database < lijopie.sql

* Add the database configuration
        
        $ vim app/php/db-info.php

        <?php

          $host = '';
          $user = '';
          $name = '';
          $pass = '';

        ?>

* Follow instructions below

        $ mkdir public/uploads && chmod 777 public/uploads
        $ npm i && run-script build

* Soft link the `public/` in your server directory, link the directory

## License

MIT
