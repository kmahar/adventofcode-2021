import Utilities

enum Direction: String {
    case forward, down, up
}

struct Movement {
    let direction: Direction
    let units: Int
}

struct PositionPart1 {
    var x: Int
    var y: Int

    mutating func move(_ movement: Movement) {
        switch movement.direction {
        case .forward:
            x += movement.units
        case .down:
            y -= movement.units
        case .up:
            y += movement.units
        }
    }
}

struct PositionPart2 {
    var x: Int
    var y: Int
    var aim: Int

    mutating func move(_ movement: Movement) {
        switch movement.direction {
        case .forward:
            x += movement.units
            y -= aim * movement.units
        case .down:
            aim -= movement.units
        case .up:
            aim += movement.units
        }
    }
}

let data = try readLines(forDay: 2).map { line -> Movement in
    let parts = line.split(separator: " ")
    let direction = Direction(rawValue: String(parts[0]))!
    let units = Int(parts[1])!
    return Movement(direction: direction, units: units)
}

var start1 = PositionPart1(x: 0, y: 0)
for movement in data {
    start1.move(movement)
}

let part1 = start1.x * abs(start1.y)
print("Part 1: \(part1)")

var start2 = PositionPart2(x: 0, y: 0, aim: 0)
for movement in data {
    start2.move(movement)
}

let part2 = start2.x * abs(start2.y)
print("Part 2: \(part2)")
