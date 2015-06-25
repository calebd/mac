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

func localThemesPath() -> String {
    return .pathWithComponents([ scriptRootPath(), "Themes" ])
}

func remoteThemesPath() -> String {
    return "~/Library/Developer/Xcode/UserData/FontAndColorThemes".stringByExpandingTildeInPath
}

println("Configuring Xcode themes.")

createSymbolicLink(SymbolicLink(
    linkPath: remoteThemesPath(),
    destinationPath: localThemesPath()
))
