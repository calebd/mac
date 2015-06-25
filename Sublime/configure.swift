import Foundation

let fileManager = NSFileManager()

struct SymbolicLink {
    var linkPath: String
    var destinationPath: String
}

func scriptRootPath() -> String {
    return .pathWithComponents([ fileManager.currentDirectoryPath, __FILE__.stringByDeletingLastPathComponent ])
}

func sublimeRootPath() -> String {
    return NSSearchPathForDirectoriesInDomains(.ApplicationSupportDirectory, .UserDomainMask, true).first as! String
}

func localInstalledPackagesPath() -> String {
    return .pathWithComponents([ scriptRootPath(), "Installed Packages" ])
}

func remoteInstalledPackagesPath() -> String {
    return .pathWithComponents([ sublimeRootPath(), "Sublime Text 2", "Installed Packages" ])
}

func localUserPackagesPath() -> String {
    return .pathWithComponents([ scriptRootPath(), "User Packages" ])
}

func remoteUserPackagesPath() -> String {
    return .pathWithComponents([ sublimeRootPath(), "Sublime Text 2", "Packages", "User" ])
}

///
/// Creates a symbolic link at `linkPath` that points to `destinationPath`.
///
func createSymbolicLink(symbolicLink: SymbolicLink) {
    fileManager.createDirectoryAtPath(symbolicLink.linkPath, withIntermediateDirectories: true, attributes: nil, error: nil)
    fileManager.removeItemAtPath(symbolicLink.linkPath, error: nil)
    fileManager.createSymbolicLinkAtPath(symbolicLink.linkPath, withDestinationPath: symbolicLink.destinationPath, error: nil)
}

createSymbolicLink(SymbolicLink(
    linkPath: remoteInstalledPackagesPath(),
    destinationPath: localInstalledPackagesPath()
))

createSymbolicLink(SymbolicLink(
    linkPath: remoteUserPackagesPath(),
    destinationPath: localUserPackagesPath()
))
