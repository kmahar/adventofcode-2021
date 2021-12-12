import Utilities

struct Cave: Hashable, Equatable {
    let name: String

    var isSmall: Bool {
        self.name.allSatisfy(\.isLowercase)
    }

    var isSmallAndCanBeVisitedTwice: Bool {
        self.isSmall && self != start && self != end
    }
}

let lines = try readLines(forDay: 12)

var caveMap = [Cave: Set<Cave>]()
for line in lines {
    let caves = line.split(separator: "-")
    let cave1 = Cave(name: String(caves[0]))
    let cave2 = Cave(name: String(caves[1]))
    if !caveMap.keys.contains(cave1) {
        caveMap[cave1] = []
    }
    caveMap[cave1]!.insert(cave2)
    if !caveMap.keys.contains(cave2) {
        caveMap[cave2] = []
    }
    caveMap[cave2]!.insert(cave1)
}

let start = Cave(name: "start")
let end = Cave(name: "end")

func visitsOneSmallCaveTwice(_ path: [Cave]) -> Bool {
    var seenSmallCaves = Set<Cave>()
    for cave in path where cave.isSmall {
        if seenSmallCaves.contains(cave) {
            return true
        }
        seenSmallCaves.insert(cave)
    }
    return false
}

func findNumberOfPaths(allowVisitingOneSmallCaveTwice: Bool) -> Int {
    var candidatePaths = [[Cave]]()
    var completePaths = [[Cave]]()

    for neighbor in caveMap[start]! {
        candidatePaths.append([start, neighbor])
    }

    while !candidatePaths.isEmpty {
        var newCandidates: [[Cave]] = []
        for candidate in candidatePaths {
            let last = candidate.last!
            guard last != end else {
                completePaths.append(candidate)
                continue
            }
            // We can only add a cave to the path if:
            for neighbor in caveMap[last]! {
                // 1. We haven't visited it before, OR
                if !candidate.contains(neighbor) ||
                    // 2. We have visited it before, but it's large, OR
                    !neighbor.isSmall ||
                    // 3. We're following part 2 rules, and the cave is small and not the start/end, and the path
                    //    doesn't already visit a different small cave twice.
                    allowVisitingOneSmallCaveTwice &&
                    neighbor.isSmallAndCanBeVisitedTwice &&
                    !visitsOneSmallCaveTwice(candidate)
                {
                    newCandidates.append(candidate + [neighbor])
                }
            }
        }
        candidatePaths = newCandidates
    }

    return completePaths.count
}

let part1 = findNumberOfPaths(allowVisitingOneSmallCaveTwice: false)
print("Part 1: \(part1)")

let part2 = findNumberOfPaths(allowVisitingOneSmallCaveTwice: true)
print("Part 2: \(part2)")
