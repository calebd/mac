import Foundation

let brewPath = "/usr/local/bin/brew"

func brewUpdate() {
    let task = NSTask.launchedTaskWithLaunchPath(brewPath, arguments: [ "update" ])
    task.waitUntilExit()
}

func brewUpgrade() {
    let task = NSTask.launchedTaskWithLaunchPath(brewPath, arguments: [ "upgrade", "--all" ])
    task.waitUntilExit()
}

func brewInstallTask(package: String) -> NSTask {
    let task = NSTask()
    task.launchPath = brewPath
    task.arguments = [ "install", package ]
    return task
}

func brewTapTask(keg: String) -> NSTask {
    let task = NSTask()
    task.launchPath = brewPath
    task.arguments = [ "install", package ]
    return task
}

println("Updating Homebrew.")
brewUpdate()
brewUpgrade()

println("Installing Homebrew packages.")
let packages = [
    "rbenv",
    "ruby-build",
    "redis",
    "postgres",
    "heroku",
    "zsh-completions",
    "git",
    "kdiff3",
    "carthage"
]
for task in packages.map(brewInstallTask) {
    task.launch()
    task.waitUntilExit()
}
