SUBLIME_ROOT = File.expand_path('~/Library/Application Support/Sublime Text 2')

def configure_sublime_installed_packages
  source = File.join(directory, 'Installed Packages')
  destination = File.join(SUBLIME_ROOT, 'Installed Packages')
  `mkdir -p "#{destination}";rm -r "#{destination}";ln -s "#{source}" "#{destination}"`
end

def configure_sublime_user_packages
  source = File.join(directory, 'User Packages')
  destination = File.join(SUBLIME_ROOT, 'Packages', 'User')
  `mkdir -p "#{destination}";rm -r "#{destination}";ln -s "#{source}" "#{destination}"`
end

configure_sublime_installed_packages
configure_sublime_user_packages
