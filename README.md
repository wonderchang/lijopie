# lijopie

Illegal parking reporting platform for tainan city
[hackpad](https://g0v.hackpad.com/--TP0maM6gaZx)

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

        $ mkdir public/uploads  && chmod 777 public/uploads
        $ mkdir public/session  && chmod 777 public/session
        $ mkdir public/response && chmod 777 public/response
        $ sudo apt-get install imagemagick
        $ npm i

* Soft link the `public/` in your server directory, link the directory

## License

MIT
