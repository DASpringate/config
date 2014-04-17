config.git
============
Configure your `bash` and `emacs` development environment as follows:

```sh
cd $HOME
git clone https://github.com/DASpringate/config.git
ln -sb config/.screenrc .
ln -sb config/.bash_profile .
ln -sb config/.bashrc .
ln -sb config/.bashrc_custom .
mv .emacs.d .emacs.d~
ln -s config/.emacs.d .
cd .emacs.d
git clone https://github.com/gabrielelanaro/emacs-for-python.git
```

For Common Lisp setup:

```
sudo apt-get sbcl
mkdir lisp
cd lisp
curl -O http://beta.quicklisp.org/quicklisp.lisp
```

Then, go into sbcl and do:

```
(load "quicklisp.lisp")
(quicklisp-quickstart:install)
(ql:add-to-init-file)
(ql:quickload "quicklisp-slime-helper")
```
