require 'fileutils'

def source_themes_path
  File.join(directory, 'Themes')
end

def destination_themes_path
  File.expand_path('~/Library/Developer/Xcode/UserData/FontAndColorThemes')
end

`rm -rf #{destination_themes_path};ln -s #{source_themes_path} #{destination_themes_path}`
