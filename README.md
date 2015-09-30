# mac

Configure my Mac.

```sh
chsh -s /bin/zsh
xcode-select --install
```

```sh
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/bundle
```

```sh
mkdir -p ~/Documents/Code/calebd
cd ~/Documents/Code/calebd
git clone https://github.com/calebd/mac
cd mac
ruby setup.rb
```

## Safari Extensions

- [JSON Formatter](https://github.com/rfletcher/safari-json-formatter)
