HOME = ENV["HOME"]

def force_link(source, destination)
  `mkdir -p "#{source}"`
  `rm -rf "#{source}"`
  `ln -Ffhs "#{destination}" "#{source}"`
end

desc "Set standard user defaults values."
task :defaults do
  `defaults write "com.apple.dock" "show-process-indicators" -bool false`
  `defaults write "com.apple.dock" "autohide" -bool true`
  `defaults write "com.apple.dock" "mineffect" "scale"`
  `defaults -currentHost write "com.apple.ImageCapture" "disableHotPlug" -bool true`
  `defaults write "com.apple.dt.Xcode" "DVTTextShowLineNumbers" -bool true`
  `defaults write "com.apple.dt.Xcode" "DVTTextEditorWrapsLines" -bool true`
  `defaults write "com.apple.dt.Xcode" "IDESourceControlAutomaticallyAddNewFiles" -bool false`
  `defaults write "com.apple.dt.Xcode" "DVTTextEditorTrimWhitespaceOnlyLines" -bool true`
  `defaults write "com.apple.dt.Xcode" "DVTTextEditorTrimTrailingWhitespace" -bool true`
  `defaults write "com.tapbots.TweetbotMac" "showStatusItem" -bool false`
  `defaults write "com.tapbots.TweetbotMac" "soundType" -int 1`

  # Mail.app
  `defaults write "com.apple.mail" "SwipeAction" -int 1`

  # Terminal.app
  `defaults write "com.apple.terminal" "ShowLineMarks" -bool false`

  # 1Password.app
  `defaults write "2BUA8C4S2C.com.agilebits.onepassword-osx-helper" "animateFill" -bool false`
end

desc "Link all dotfiles to files in this repository."
task :dotfiles do
  ["gemrc", "gitconfig", "gitignore", "zsh", "zshrc", "hammerspoon", "lldbinit"].each do |file|
    source = File.join(HOME, ".#{file}")
    destination = File.join(Dir.pwd, "Dotfiles", file)
    `rm -rf "#{source}";ln -s "#{destination}" "#{source}"`
  end
end

desc "Link shared Xcode assets to files in this repository."
task :xcode do
  source = File.join(HOME, "Library", "Developer", "Xcode", "UserData", "FontAndColorThemes")
  destination = File.join(Dir.pwd, "Xcode", "Themes")
  force_link(source, destination)
end

desc "Run all setup tasks."
task :setup => [:defaults, :dotfiles, :xcode] do
end
