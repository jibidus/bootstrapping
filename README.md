# Bootsrapping

**WARNING** Under development

Automated procedure to bootstrap a new computer with:
- Brew formula
- Brew casks
- Git config

# How to execute bootstrapping?
- Install Homebrew
```
TO COMPLETE
```

- Install git
```
brew install git
```

- Create git ssh key
```
TO COMPLETE
```

- Clone this repository
```
mkdir ~/Development
cd ~/Development
git clone git@github.com:jibidus/bootstraping.git
```

- Run bootstraping script
```
~/Development/bootstrapping/bootstrap.sh
```

# TODO
- [ ] Complete README
- [ ] Split script
- [ ] Schedule homebrew upgrade
  * brew upgrade
  * brew-cask.sh upgrade
- [ ] Ruby upgrade / install
  * Upgrade rbenv ruby versions lists : cd .rbenv/plugins/ruby-build && git pull
