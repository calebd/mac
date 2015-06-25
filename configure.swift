import Foundation

let fileManager = NSFileManager()

struct SwiftScript: DebugPrintable {
    var path: String

    var task: NSTask {
        let task = NSTask()
        task.launchPath = "/usr/bin/swift"
        task.arguments = [ path ]
        return task
    }

    var debugDescription: String {
        return "/usr/bin/swift \"\(path)\""
    }
}

func run(script: SwiftScript) {
    let task = script.task
    task.launch()
    task.waitUntilExit()
}

func scriptRootPath() -> String {
    return .pathWithComponents([ fileManager.currentDirectoryPath, __FILE__.stringByDeletingLastPathComponent ])
}

func scripts() -> [SwiftScript] {
    let rootPath = scriptRootPath()
    let paths = fileManager.enumeratorAtPath(rootPath)?.allObjects as? [String] ?? []
    return paths
        .filter({ $0.lastPathComponent == "configure.swift" })
        .filter({ $0.pathComponents.count > 1 })
        .map({ String.pathWithComponents([ rootPath, $0 ]) })
        .map({ SwiftScript(path: $0) })
}

for script in scripts() {
    run(script)
}
