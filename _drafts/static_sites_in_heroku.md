---
title: "How to host static sites in Heroku"
description: "Style reference"
layout: post
---

* * * *

Just add an `index.php` to your repository.
It tells Heroku that the site is a PHP site and that it will be hosted using 
Apache.
{: .brief}

    touch index.php

And yes, you can still have an `index.html` file. The `.html` file takes 
precedence over the `.php` one. Have fun!
