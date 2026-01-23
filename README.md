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
- [ ] Add documentation to scripts
- [ ] Install AppStore app with [mas](https://github.com/mas-cli/mas)
- [ ] Remplacer asdf par [mise](https://codeka.io/2025/12/19/adieu-direnv-bonjour-mise/)
