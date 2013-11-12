config.git
============
Clone and run this on a new EC2 instance running Ubuntu 12.04.2 LTS to
configure your `bash` and `emacs` development environment as follows:

```sh
cd $HOME
git clone https://github.com/DASpringate/config.git
ln -sb config/.screenrc .
ln -sb config/.bash_profile .
ln -sb config/.bashrc .
ln -sb config/.bashrc_custom .
mv .emacs.d .emacs.d~
ln -s config/.emacs.d .
```

See the
[Startup Engineering Video Lectures 4a/4b](https://class.coursera.org/startup-001/lecture/index)
for more details.
