# mac

Configure my Mac.

```sh
chsh -s /bin/zsh
xcode-select --install
```

```sh
# Install homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Download this repository
mkdir -p ~/Documents/Code/calebd
cd ~/Documents/Code/calebd
git clone https://github.com/calebd/mac
cd mac

# Run setup scripts
ruby setup.rb
brew bundle
```

## Safari Extensions

- [JSON Formatter](https://github.com/rfletcher/safari-json-formatter)
- [Un-UTM](https://github.com/josephschmitt/un-utm)
