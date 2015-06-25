import Foundation

let fileManager = NSFileManager()

struct SymbolicLink {
    var linkPath: String
    var destinationPath: String
}

///
/// Creates a symbolic link at `linkPath` that points to `destinationPath`.
///
func createSymbolicLink(symbolicLink: SymbolicLink) {
    fileManager.createDirectoryAtPath(symbolicLink.linkPath, withIntermediateDirectories: true, attributes: nil, error: nil)
    fileManager.removeItemAtPath(symbolicLink.linkPath, error: nil)
    fileManager.createSymbolicLinkAtPath(symbolicLink.linkPath, withDestinationPath: symbolicLink.destinationPath, error: nil)
}

func scriptRootPath() -> String {
    return __FILE__.stringByDeletingLastPathComponent
}

func sublimeRootPath() -> String {
    return "~/Library/Application Support/Sublime Text 2".stringByExpandingTildeInPath
}

func localInstalledPackagesPath() -> String {
    return .pathWithComponents([ scriptRootPath(), "Installed Packages" ])
}

func remoteInstalledPackagesPath() -> String {
    return .pathWithComponents([ sublimeRootPath(), "Installed Packages" ])
}

func localUserPackagesPath() -> String {
    return .pathWithComponents([ scriptRootPath(), "User Packages" ])
}

func remoteUserPackagesPath() -> String {
    return .pathWithComponents([ sublimeRootPath(), "Packages", "User" ])
}

println("Configuring Sublime packages.")

createSymbolicLink(SymbolicLink(
    linkPath: remoteInstalledPackagesPath(),
    destinationPath: localInstalledPackagesPath()
))

createSymbolicLink(SymbolicLink(
    linkPath: remoteUserPackagesPath(),
    destinationPath: localUserPackagesPath()
))
