# Bootsrapping

**WARNING** Under development

Automated procedure to bootstrap a new computer with:
- Brew formula
- Brew casks
- Git config

# How to execute bootstrapping?
- Install Homebrew
```bash
TO COMPLETE
```

- Install git
```bash
brew install git
```

- Create git ssh key
```bash
TO COMPLETE
```

- Clone this repository
```bash
mkdir ~/Development
cd ~/Development
git clone git@github.com:jibidus/bootstraping.git
```

- Install ruby
```bash
brew install brenv
```
# TODO Finalize rbenv installation

- Run bootstraping script
```bash
ruby ~/Development/bootstrapping/bootstrap.sh
```

# TODO
- [ ] Complete README
- [ ] Split scripts
- [ ] Schedule homebrew upgrade
  * brew upgrade
  * brew-cask.sh upgrade
- [ ] Ruby upgrade / install
  * Upgrade rbenv ruby versions lists : cd .rbenv/plugins/ruby-build && git pull
- [ ] Add documentation to scripts
- [ ] Install AppStore app
