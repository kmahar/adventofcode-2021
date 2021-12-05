import Utilities

struct Point: Hashable {
    let x: Int
    let y: Int
}

struct Line {
    let start: Point
    let end: Point

    enum Direction {
        case horizontal
        case vertical
        case diagonal
    }

    var direction: Direction {
        if self.start.x == self.end.x {
            return .vertical
        } else if self.start.y == self.end.y {
            return .horizontal
        } else {
            return .diagonal
        }
    }
}

let data = try readLines(forDay: 5).map { line -> Line in
    let components = line.split(separator: " ")
    let startData = components[0].split(separator: ",")
    let x1 = Int(startData[0])!
    let y1 = Int(startData[1])!
    let endData = components[2].split(separator: ",")
    let x2 = Int(endData[0])!
    let y2 = Int(endData[1])!
    return Line(start: Point(x: x1, y: y1), end: Point(x: x2, y: y2))
}

func getIntersectionCounts(_ lines: [Line]) -> [Point: Int] {
    var counts = [Point: Int]()
    for line in lines {
        switch line.direction {
        case .horizontal:
            for x in min(line.start.x, line.end.x)...max(line.start.x, line.end.x) {
                let point = Point(x: x, y: line.start.y)
                counts[point, default: 0] += 1
            }
        case .vertical:
            for y in min(line.start.y, line.end.y)...max(line.start.y, line.end.y) {
                let point = Point(x: line.start.x, y: y)
                counts[point, default: 0] += 1
            }
        case .diagonal:
            // m = (y2 - y1) / (x2 - x1)
            let m = Double(line.end.y - line.start.y) / Double(line.end.x - line.start.x)
            // b = y - mx
            let b = Double(line.start.y) - m * Double(line.start.x)
            for x in min(line.start.x, line.end.x)...max(line.start.x, line.end.x) {
                // y = mx + b
                let y = m * Double(x) + b
                let point = Point(x: x, y: Int(y))
                counts[point, default: 0] += 1
            }
        }
    }

    return counts
}

let intersectionsPt1 = getIntersectionCounts(data.filter { $0.direction != .diagonal })
let part1 = intersectionsPt1.filter { $0.1 >= 2 }.count
print("Part 1: \(part1)")

let intersectionsPt2 = getIntersectionCounts(data)
let part2 = intersectionsPt2.filter { $0.1 >= 2 }.count
print("Part 2: \(part2)")
