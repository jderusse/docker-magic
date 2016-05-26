Docker-magic
============

This docker image is a POC to provide a php image WITHOUT sources

Proof
-----

```
$ docker run jderusse/magic:symfony /srv/app/console -v
Symfony version 2.8.4-DEV - app/prod

$ docker run jderusse/magic:symfony cat /srv/app/AppKernel.php

$ docker run jderusse/magic:symfony ls -al /srv/app
total 140
drwxr-xr-x    7 1337     1337          4096 May 26 21:38 .
drwxr-xr-x    7 1337     1337          4096 May 26 21:38 ..
-rw-r--r--    1 1337     1337           143 Apr  3 09:52 .htaccess
-rw-r--r--    1 1337     1337             0 May 26 21:38 AppCache.php
-rw-r--r--    1 1337     1337             0 May 26 21:38 AppKernel.php
drwxr-xr-x    6 1337     1337          4096 May 26 21:38 Resources
-rw-r--r--    1 1337     1337             0 May 26 21:38 SymfonyRequirements.php
-rw-r--r--    1 1337     1337             0 May 26 21:38 autoload.php
-rw-r--r--    1 1337     1337        102026 Apr  3 09:52 bootstrap.php.cache
drwxrwxrwx    3 1337     1337          4096 May 26 21:38 cache
-rw-r--r--    1 1337     1337             0 May 26 21:38 check.php
drwxr-xr-x    2 1337     1337          4096 May 26 21:38 config
-rwxr-xr-x    1 1337     1337           880 Apr  3 09:52 console
drwxr-xr-x    2 1337     1337          4096 May 26 21:38 data
drwxrwxrwx    2 1337     1337          4096 May 26 21:38 logs
-rw-r--r--    1 1337     1337          1496 Apr  3 09:52 phpunit.xml.dist
```
> every PHP file have a size of `0` byte.


The original source code is the official [Symfony Demo application](https://github.com/symfony/symfony-demo).
But, as you can notice, each `.php` file are empty.


To browse the application use :
```
$ docker run -ti -p 8000:8000 jderusse/magic:symfony /srv/app/console server:run 0.0.0.0:8000 -vvv

```
Then open the web page with you favorite browser [http://127.0.0.1:8000](http://127.0.0.1:8000)


How does it work ?
------------------

The original source code is downloaded then compiled by the php engine with a
simple `php -l`.
The compiled result is stored in the opcache files.

Thanks to the directive `validate_timestamps=0` the original files are not
used anymore. You can empty thoses file, the application still works because
the engine will always use the opcached files.
