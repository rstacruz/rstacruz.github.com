---
title: "Untangle your dotfiles"
description: "How to use dotfiles for fun and profit"
layout: post
---

There are many solutions for managing your home directory's dot files today.  
For the most part, you don't really need them. Here's a simpler way with no 
dependencies.
{: .brief}

* * * *

Put your dotfiles (without the dot prefix) in a folder in a repository. You can 
also put subdirectories in if you like, such as `vim` and `aria2` here below.

```
~/dotfiles
 ├── ackrc
 ├── vimrc
 ├── ledgerrc
 ├── gemrc
 ├── vim/
 │   ├── after/
 │   ├── bundle/
 │   └── ...
 ├── aria2/
 │   ├── aria2.conf
 │   └── ...
 └── ...
```

### Create an install script
Then add this script as `install.sh`. This will link each of the files into the 
home folder.

<div class='with-footnote -left'>
> Save this as `install.sh`.
> Be sure to `chmod +x install.sh` afterwards.

```shell
#!/usr/bin/sh
echo "\n  linking from `pwd -LP`\n"
for f in *; do
  if [ "$f" != "install.sh" ]; then
    echo "  .." ~/.`basename $f`
    ln -nfs `pwd -LP`/$f ~/.`basename $f`
  fi
done
```
</div>

### Run it
When you run the install script, it will link the files from the current 
directory into your home directory (eg: `/home/rsc/dotfiles/ackrc` into 
    `~/.ackrc`).

```
◦ ./install.sh

  linking from /home/rsc/dotfiles

  .. /home/rsc/.ackrc
  .. /home/rsc/.vimrc
  .. /home/rsc/.ledgerrc
  .. /home/rsc/.gemrc
  .. /home/rsc/.vim
  .. /home/rsc/.aria2
```

* * * *

## Share your setup!

There are many dotfile repositories out there in GitHub. Share yours, too! Just 
be sure you don't keep any secrets in there (like `~/.ssh`).
