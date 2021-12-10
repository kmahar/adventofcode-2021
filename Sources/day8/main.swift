import Utilities

enum Segment: String, Hashable {
    case a, b, c, d, e, f, g
}

struct Entry {
    let patterns: Set<Set<Segment>>
    let output: [Set<Segment>]
}

let data = try readLines(forDay: 8)
let entries = data.map { line -> Entry in
    let parts = line.split(separator: "|")
    let patterns = Set(
        parts[0]
            .split(separator: " ")
            .map { Set(Array($0).map { Segment(rawValue: String($0))! }) })
    let output = parts[1]
        .split(separator: " ")
        .map { Set(Array($0).map { Segment(rawValue: String($0))! }) }
    return Entry(patterns: patterns, output: output)
}

let uniqueSegmentCountDigits = [2, 3, 4, 7]
let part1Count = entries.map { entry in
    entry.output.filter { uniqueSegmentCountDigits.contains($0.count) }.count
}.reduce(0, +)
print("Part 1: \(part1Count)")

func findOutputValue(for entry: Entry) -> Int {
    // 1 is the only number with exactly 2 segments.
    let oneSegments = entry.patterns.first { $0.count == 2 }!
    // 7 is the only number with exactly 3 segments.
    let sevenSegments = entry.patterns.first { $0.count == 3 }!
    // 4 is the only number with exactly 4 segments.
    let fourSegments = entry.patterns.first { $0.count == 4 }!
    // 8 is the only number with exactly 7 segments.
    let eightSegments = entry.patterns.first { $0.count == 7 }!

    // Map unique sets of segments to the digits they correspond to.
    var segmentsToNumbers = [
        oneSegments: 1,
        sevenSegments: 7,
        fourSegments: 4,
        eightSegments: 8
    ]

    // Segments we've yet to assign to positions.
    var unassignedSegments: Set<Segment> = [.a, .b, .c, .d, .e, .f, .g]

    // The bottom left segment is the only one included in exactly 4 digits.
    let bottomLeft = unassignedSegments.first { segment in
        entry.patterns.filter { $0.contains(segment) }.count == 4
    }!
    unassignedSegments.remove(bottomLeft)

    // The bottom right segment is the only one included in exactly 9 digits.
    let bottomRight = unassignedSegments.first { segment in
        entry.patterns.filter { $0.contains(segment) }.count == 9
    }!
    unassignedSegments.remove(bottomRight)

    // The top left segment is the only one included in exactly 6 digits.
    let topLeft = unassignedSegments.first { segment in
        entry.patterns.filter { $0.contains(segment) }.count == 6
    }!
    unassignedSegments.remove(topLeft)

    // The top right segment is the one that is in both 1 and 7, but isn't the bottom right.
    let topRight = oneSegments.first { $0 != bottomRight }!
    unassignedSegments.remove(topRight)

    // The one non-overlapping segment between 1 and 7 is the top edge.
    let top = sevenSegments.subtracting(oneSegments).first!
    unassignedSegments.remove(top)

    // The bottom segment is the only segment besides the top that appears in every still-unassigned number.
    let unassignedNumbers = entry.patterns.subtracting(Set([oneSegments, sevenSegments, fourSegments, eightSegments]))
    let bottom = unassignedNumbers.reduce(unassignedNumbers.first!) { s1, s2 in
        s1.intersection(s2)
    }.first { $0 != top }!
    unassignedSegments.remove(bottom)

    // By process of elimination, the middle is the only digit left.
    let middle = unassignedSegments.first!
    unassignedSegments.remove(middle)

    // We can now manually fill the rest of these in.
    segmentsToNumbers[Set([top, topRight, middle, bottomLeft, bottom])] = 2
    segmentsToNumbers[Set([top, topRight, middle, bottomRight, bottom])] = 3
    segmentsToNumbers[Set([top, topLeft, middle, bottomRight, bottom])] = 5
    segmentsToNumbers[Set([top, topLeft, middle, bottomLeft, bottomRight, bottom])] = 6
    segmentsToNumbers[Set([top, topLeft, topRight, middle, bottomRight, bottom])] = 9
    segmentsToNumbers[Set([top, topLeft, topRight, bottomLeft, bottomRight, bottom])] = 0

    let outputStr = entry.output.map { String(segmentsToNumbers[$0]!) }.reduce("", +)
    return Int(outputStr)!
}

let part2 = entries.map { findOutputValue(for: $0) }.reduce(0, +)
print("Part 2: \(part2)")
