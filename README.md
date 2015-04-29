# lijopie

Illegal parking reporting platform for tainan city
[hackpad](https://g0v.hackpad.com/--TP0maM6gaZx)

## Build

* Create database and import the database structure

        $ mysql -u username -p database < lijopie.sql

* Add the developing configuration
        
        $ vim config.json

        {
          "express": {        # Express server port
            "port": 9999
          },
          "mysql": {          # MySQL config
            "port": 3306,
            "host": "",
            "user": "",
            "password": "",
            "database": ""
          },
          "agency": {         # Reporting agency info
            "name": "",
            "gmail": {
              "user": "",
              "pass": ""
            }
          },
          "system": {         # System mode
            "report": false,
            "imap": false
          }
        }

  `system.report`: Whether really report to police officer or not
  `system.imap`: Whether receive mail for capture the reporting response mail

  Suggest setting these two system parameter `false` during developing (e.g. front-end), only developing some back-end part required `true`.

* Required some tools

  For Linux
        
        $ apt-get install imagemagick

  For Mac, use brew to install
        
        $ brew install imagemagick

* Follow instructions below
        
        $ npm i
        & npm start
        $ mkdir public/uploads  && chmod 777 public/uploads
        $ mkdir public/session  && chmod 777 public/session
        $ mkdir public/response && chmod 777 public/response

* Soft link the `public/` in your server directory, link the directory

## MIT License

Copyright (C) 2015 lijopie 

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

