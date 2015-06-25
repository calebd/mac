import Foundation

// MARK: - Setup

let brewPath = "/usr/local/bin/brew"

func compact<T, S: SequenceType where S.Generator.Element == T?>(sequence: S) -> [T] {
    return reduce(sequence, [T](), { array, element in
        switch element {
        case .Some(let value):
            return array + [ value ]
        default:
            return array
        }
    })
}

public struct JSON {
    private var object: AnyObject?

    public init?(data: NSData) {
        object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
        if object == nil {
            return nil
        }
    }

    public init(object: AnyObject? = nil) {
        self.object = object
    }

    public subscript(index: Int) -> JSON {
        return array?[index] ?? JSON()
    }

    public subscript(key: String) -> JSON {
        return dictionary?[key] ?? JSON()
    }

    public var string: String? {
        return object as? String
    }

    public var dictionary: [String: JSON]? {
        if let dictionary = object as? [String: AnyObject] {
            var mutableDictionary = [String: JSON]()
            for (key, value) in dictionary {
                mutableDictionary[key] = JSON(object: value)
            }
            return mutableDictionary
        }
        return nil
    }

    public var array: [JSON]? {
        if let array = object as? [AnyObject] {
            return array.map({ JSON(object: $0) })
        }
        return nil
    }

    public var int: Int? {
        return object as? Int
    }

    public var double: Double? {
        return object as? Double
    }

    public var bool: Bool? {
        return object as? Bool
    }

    public var url: NSURL? {
        return string.flatMap({ NSURL(string: $0) })
    }

    public var timeInterval: NSTimeInterval? {
        return object as? NSTimeInterval
    }

    public var date: NSDate? {
        return timeInterval.map({ NSDate(timeIntervalSince1970: $0) })
    }
}

protocol TaskType {}

struct SymbolicLinkTask: TaskType, DebugPrintable {
    var linkPath: String
    var destinationPath: String

    init?(json: JSON) {
        switch (json["source"].string, json["destination"].string) {
        case (.Some(let source), .Some(let destination)):
            linkPath = source
            destinationPath = destination
        default:
            return nil
        }
    }

    var debugDescription: String {
        return "mkdir -p \"\(linkPath)\";rm -rf \"\(linkPath)\";ln -s \"\(linkPath)\" \"\(destinationPath)\""
    }
}

struct BrewTask: TaskType, DebugPrintable {
    var arguments: [String]

    init?(json: JSON) {
        if let arguments = json["arguments"].array?.map({ $0.string }) {
            self.arguments = compact(arguments)
        }
        else {
            return nil
        }
    }

    init(arguments: [String]) {
        self.arguments = arguments
    }

    var debugDescription: String {
        let array = " ".join(arguments)
        return "\(brewPath) \(array)"
    }
}

struct BrewInstallTask: TaskType, DebugPrintable {
    var packages: [String]

    init?(json: JSON) {
        if let packages = json["packages"].array?.map({ $0.string }) {
            self.packages = compact(packages)
        }
        else {
            return nil
        }
    }

    var debugDescription: String {
        let array = " ".join(packages.map({ "'\($0)'" }))
        return "\(brewPath) install \(array)"
    }
}

func decode(json: JSON) -> TaskType? {
    return json["type"].string.flatMap({
        switch $0 {
        case "symlink":
            return SymbolicLinkTask(json: json)
        case "brew":
            return BrewTask(json: json)
        case "brewinstall":
            return BrewInstallTask(json: json)
        default:
            return nil
        }
    })
}

struct Manifest {
    var tasks: [TaskType]

    init?(json: JSON) {
        switch (json["tasks"].array?.map(decode)) {
        case (.Some(let tasks)):
            self.tasks = compact(tasks)
        default:
            return nil
        }
    }
}

// MARK: - Execute

let fileManager = NSFileManager()

let manifestPath = String.pathWithComponents([
    fileManager.currentDirectoryPath,
    __FILE__.stringByDeletingLastPathComponent,
    "manifest.json"
])

let manifest = NSData(contentsOfFile: manifestPath)
    .flatMap({ JSON(data: $0) })
    .flatMap({ Manifest(json: $0) })
println(manifest?.tasks)
