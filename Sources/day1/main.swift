import Utilities

let data = try readLines(forDay: 1).map { Int($0)! }

/// Part 1
let part1 = (1 ..< data.count).filter { data[$0] > data[$0 - 1] }.count
print("Part 1: \(part1)")

/// Part 2
let part2 = (1 ..< (data.count - 2)).filter { data[$0 + 2] > data[$0 - 1] }.count
print("Part 2: \(part2)")
