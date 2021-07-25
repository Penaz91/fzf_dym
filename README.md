FZF-DYM
=======

A simple VimScript "Did you Mean..." plugin based on FZF. Based on my personal VimRC, now extracted to a standalone plugin

Requirements
------------

- [FZF](https://github.com/junegunn/fzf)
- [FZF.vim](https://github.com/junegunn/fzf.vim)

Setup
-----

I personally use vim-plug, but this can probably be adapted to other systems

```
Plug 'penaz91/fzf_dym'
```

How it works
------------

Let's imagine a situation where you have a folder with 3 similarly-named files: `readme_1.txt`, `readme_2.txt`, `readme_3.txt`.

You want to give a quick glance to `readme_2.txt` so you do:

```
$ nvim re<TAB><CR>
```

Your shell will probably complete the filename as `readme_`, but it's too late. You pressed enter. Instead of creating a new file that is called `readme_`, FZF-DYM will ask if you meant any of the existing files. After you select the file to read via FZF, you're set.

Don't want to read one of the existing files? Just press ESC and nvim will fall back to its default behaviour.
