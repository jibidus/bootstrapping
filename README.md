![tests](https://github.com/jibidus/bootstrapping/actions/workflows/tests.yml/badge.svg)

# Bootsrap new laptop

Automated procedure to bootstrap a new computer with all necessary tools like:

- `oh-my-zsh`
- `iterm2`
- `asdf`
- `chezmoi`

# How to bootstrap a new laptop?

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install git
git clone https://github.com/jibidus/bootstrapping.git
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
- [ ] Replace rbenv by asdf in bootstrap.sh
