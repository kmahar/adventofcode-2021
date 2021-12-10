import Utilities

let data = try readLines(forDay: 9).map { Array($0).map { Int(String($0))! } }
let xMax = data[0].count
let yMax = data.count
struct Point: Hashable {
    let x: Int
    let y: Int

    func getSurroundingPoints() -> [Point] {
        var output = [Point]()
        if self.x >= 1 {
            output.append(Point(x: self.x - 1, y: self.y))
        }
        if self.x < xMax - 1 {
            output.append(Point(x: self.x + 1, y: self.y))
        }
        if self.y >= 1 {
            output.append(Point(x: self.x, y: self.y - 1))
        }
        if self.y < yMax - 1 {
            output.append(Point(x: self.x, y: self.y + 1))
        }
        return output
    }

    func getValue() -> Int {
        data[self.y][self.x]
    }

    func isLowPoint() -> Bool {
        let value = self.getValue()
        let surroundingHeights = self.getSurroundingPoints().map { $0.getValue() }
        return surroundingHeights.allSatisfy { $0 > value }
    }

    func flowsToPoint() -> Point {
        guard !self.isLowPoint() else {
            fatalError("Low point does not flow anywhere")
        }
        return self.getSurroundingPoints().min { p1, p2 in p1.getValue() < p2.getValue() }!
    }
}

var part1 = 0
for x in 0..<xMax {
    for y in 0..<yMax {
        let point = Point(x: x, y: y)
        if point.isLowPoint() {
            part1 += point.getValue() + 1
        }
    }
}

print("Part 1: \(part1)")

// Stores the count of all other points that flow to this point on their way to a low point.
var pointFlowCounts = [Point: Int]()
// Map of low points to basin sizes.
var basinSizes = [Point: Int]()

// Populate the initial maps.
for x in 0..<xMax {
    for y in 0..<yMax {
        let point = Point(x: x, y: y)
        guard point.getValue() != 9 else {
            continue
        }
        if point.isLowPoint() {
            basinSizes[point] = 1
        } else {
            pointFlowCounts[point] = 1
        }
    }
}

// Here we basically run a simulation of lava flowing through the map with one "unit" of lava flowing from each spot
// with height < 9 (since height 9 spots are not considered part of any basin.)
// On each iteration we figure out which point all the remaining lava would flow to and update our view accordingly.
// Once all lava has reached a low point, the count at each low point is equivalent to the size of the basin.
while !pointFlowCounts.isEmpty {
    var newFlowCounts = [Point: Int]()

    for (point, flowCount) in pointFlowCounts {
        let flowsTo = point.flowsToPoint()
        if flowsTo.isLowPoint() {
            basinSizes[flowsTo]! += flowCount
        } else {
            newFlowCounts[flowsTo] = newFlowCounts[flowsTo, default: 0] + flowCount
        }
    }

    pointFlowCounts = newFlowCounts
}

var basins = Array(basinSizes)
basins.sort { a, b in a.value > b.value }
let part2 = basins[0].value * basins[1].value * basins[2].value
print("Part 2: \(part2)")
