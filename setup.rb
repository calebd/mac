HOME = ENV["HOME"]

def force_link(source, destination)
  `mkdir -p "#{source}"`
  `rm -rf "#{source}"`
  `ln -Ffhs "#{destination}" "#{source}"`
end

source = File.join(HOME, "Library", "Application Support", "Sublime Text 2", "Installed Packages")
destination = File.join(Dir.pwd, "Sublime", "Installed Packages")
force_link(source, destination)

source = File.join(HOME, "Library", "Application Support", "Sublime Text 2", "Packages", "User")
destination = File.join(Dir.pwd, "Sublime", "User Packages")
force_link(source, destination)

source = File.join(HOME, "Library", "Developer", "Xcode", "UserData", "FontAndColorThemes")
destination = File.join(Dir.pwd, "Xcode", "Themes")
force_link(source, destination)

[ "gemrc", "gitconfig", "gitignore", "zsh", "zshrc" ].each do |file|
  source = File.join(HOME, ".#{file}")
  destination = File.join(Dir.pwd, "Dotfiles", file)
  `rm -rf "#{source}";ln -s "#{destination}" "#{source}"`
end

source = File.join(HOME, "Brewfile")
destination = File.join(Dir.pwd, "Brewfile")
`rm -f "#{source}";ln -Ffhs "#{destination}" "#{source}"`

`defaults write "com.apple.dock" "show-process-indicators" -bool false`
`defaults write "com.apple.dock" "autohide" -bool true`
`defaults write "com.apple.dock" "mineffect" "scale"`
