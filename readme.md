Plugin Deploy from Git
=====

## Usage

1) Clone: `git clone https://github.com/mustafauysal/deploy-from-git.git`

2) Define alias or, export path
```
alias plugin-deploy='sh ~/scripts/plugin-deploy.sh'

alias plugin-tag='sh ~/scripts/plugin-tag.sh'
```

3) Change WordPress.org svn username SVN_USERNAME and DEST_DIR in `plugin-deploy.sh` file

4) Run `plugin-deploy` command in your plugin's git repo

5) Have fun, and remember to use `plugin-tag 1.0.1` for tagging.


## Credits

* Scribu for original script – http://scribu.net/blog/deploying-from-git-to-svn.html
