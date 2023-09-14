# Bootsrapping

**WARNING** Under development

Automated procedure to bootstrap a new computer with:
- Brew formula
- Brew casks
- Git config

# How to execute bootstrapping?
- Install Homebrew
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
- Install git
```bash
brew install git
```

- Clone this repository
```bash
git clone https://github.com/jibidus/bootstrapping.git
```

- Run bootstraping script
```bash
cd bootstrapping
./bootstrap.sh
```

# TODO
- [ ] Take inspiration from https://github.com/nicolinuxfr/macOS-post-installation
- [ ] Split scripts
- [ ] Schedule updates (update-all.sh)
- [ ] Ruby upgrade / install
  * Upgrade rbenv ruby versions lists : cd .rbenv/plugins/ruby-build && git pull
- [ ] Add documentation to scripts
- [ ] Install AppStore app
  * See https://github.com/nicolinuxfr/macOS-post-installation/blob/master/post-install.sh
