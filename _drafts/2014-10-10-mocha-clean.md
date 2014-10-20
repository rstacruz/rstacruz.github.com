---
title: Cleaner Mocha stack traces
date: 2014/10/10
layout: article
tags: [Development, JavaScript]
---

[Mocha] is a great way to test JavaScript, but its stack traces are riddled
with useless frames from Mocha internals and 3rd-party modules. Let's try and
clean it up.
{:.brief-intro.center}

![Image](https://raw.githubusercontent.com/rstacruz/mocha-clean/gh-pages/comparison.png)
{:.full-image.crop}

<br>

### Introducing mocha-clean

`mocha-clean` is a plugin for Mocha. It strips away mocha internals,
node_modules, absolute paths (based on cwd), and other unneccessary cruft
from stack traces.
Simply invoke Mocha with `-r mocha-clean`. The easiest way to do this is to add
it to your *test/mocha.opts* file.

<div class='with-footnote left'>
> *test/mocha.opts*<br>
> Create it if it doesn't exist.

~~~
--require mocha-clean
~~~
</div>

* * * *

### Try it out

It's available via npm, and works with Mocha 1.x in Node.js and in the browser.
The source is available in GitHub: [rstacruz/mocha-clean][src].

```sh
$ npm install --save-dev mocha-clean
```

[src]: https://github.com/rstacruz/mocha-clean
[Mocha]: http://visionmedia.github.io/mocha

