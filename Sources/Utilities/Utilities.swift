import Foundation

public func readFile(forDay day: Int) throws -> String {
    let path = "./data/day\(day)"
    return try String(contentsOfFile: path, encoding: .utf8)
}

public func readLines(forDay day: Int, omittingEmptySubsequences: Bool = true) throws -> [String.SubSequence] {
    try readFile(forDay: day).split(separator: "\n", omittingEmptySubsequences: omittingEmptySubsequences)
}
