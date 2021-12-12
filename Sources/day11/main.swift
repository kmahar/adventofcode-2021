import Utilities

struct Point: Hashable, CustomDebugStringConvertible {
    let x: Int
    let y: Int

    func getSurroundingPoints() -> [Point] {
        var output = [Point]()
        if self.x >= 1 {
            output.append(Point(x: self.x - 1, y: self.y))

            if self.y >= 1 {
                output.append(Point(x: self.x - 1, y: self.y - 1))
            }
            if self.y < yMax - 1 {
                output.append(Point(x: self.x - 1, y: self.y + 1))
            }
        }
        if self.x < xMax - 1 {
            output.append(Point(x: self.x + 1, y: self.y))

            if self.y >= 1 {
                output.append(Point(x: self.x + 1, y: self.y - 1))
            }
            if self.y < yMax - 1 {
                output.append(Point(x: self.x + 1, y: self.y + 1))
            }
        }
        if self.y >= 1 {
            output.append(Point(x: self.x, y: self.y - 1))
        }
        if self.y < yMax - 1 {
            output.append(Point(x: self.x, y: self.y + 1))
        }
        return output
    }

    var debugDescription: String {
        "(\(self.x), \(self.y))"
    }
}

func handleFlash(at point: Point, in data: inout [[Int]], alreadyFlashed: inout Set<Point>) {
    guard !alreadyFlashed.contains(point) else {
        return
    }
    alreadyFlashed.insert(point)
    // Increase the energy level of all adjacent octopuses by 1.
    for neighbor in point.getSurroundingPoints() {
        data[neighbor.y][neighbor.x] += 1
        // If this causes an octopus to have an energy level greater than 9, it also flashes.
        if data[neighbor.y][neighbor.x] > 9 {
            handleFlash(at: neighbor, in: &data, alreadyFlashed: &alreadyFlashed)
        }
    }
}

/// Simulates one step. Returns the number of octopuses that flashed during the step.
func step(data: inout [[Int]]) -> Int {
    // First, the energy level of each octopus increases by 1.
    for x in 0..<xMax {
        for y in 0..<yMax {
            data[y][x] += 1
        }
    }

    // Track octopuses that have already flashed, since an octopus can only flash at most once per step.
    var alreadyFlashed = Set<Point>()

    // Scan through the whole grid once for flashing octopuses.
    for x in 0..<xMax {
        for y in 0..<yMax where data[y][x] > 9 {
            handleFlash(at: Point(x: x, y: y), in: &data, alreadyFlashed: &alreadyFlashed)
        }
    }

    // Finally, any octopus that flashed during this step has its energy level set to 0, as it used all of its energy
    // to flash.
    for point in alreadyFlashed {
        data[point.y][point.x] = 0
    }

    return alreadyFlashed.count
}

let data = try readLines(forDay: 11).map { Array($0).map { Int(String($0))! } }
let xMax = data[0].count
let yMax = data.count

var copy1 = data
let part1 = (1...100).map { _ in step(data: &copy1) }.reduce(0, +)
print("Part 1: \(part1)")

var copy2 = data
var step = 0
var flashCount = 0
while flashCount != 100 {
    step += 1
    flashCount = step(data: &copy2)
}

print("Part 2: \(step)")
