---
title: "How to host static sites in Heroku"
description: "Style reference"
layout: post
---

## Just add an `index.php` to your repository.

    touch index.php

Yes, that's all it takes. It tells Heroku that the site is a PHP site and that 
it will be hosted using Apache.
And yes, you can still have an `index.html` file. The .html file takes 
precedence over the .php one.
