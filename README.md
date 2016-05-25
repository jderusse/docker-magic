Docker-magic
============

This docker image is a POC to provide a php image WITHOUT sources

Proof
-----

```
$ docker run jderusse/magic php /srv/index.php
Hello World

$ docker run jderusse/magic cat /srv/index.php

$ docker run jderusse/magic ls -al /srv/index.php
-rw-r--r--    1 root     root             1 May 25 21:57 /srv/index.php
```

> `1` is the size of the file in bytes.


The original source code is available here : https://gist.githubusercontent.com/jderusse/81050a514f2136efabab5ebd520bc598

How does it work ?
------------------

The original source code is downloaded then compiled by the php engine with a
simple `php -l`.
The compiled result is stored in the opcache files.

Thanks to the directive `validate_timestamps=0` the original files are not
used anymore. You can empty thoses file, the application still works because
then engine will always use the opcached files.