import Utilities

struct Point: Hashable {
    let x: Int
    let y: Int
}

struct BingoBoard {
    let numbers: [Int: Point]
    var visited: Set<Point> = []

    mutating func processNumber(_ number: Int) {
        guard let location = self.numbers[number] else {
            return
        }
        self.visited.insert(location)
    }

    var hasWon: Bool {
        // check rows
        for y in 0..<5 {
            let visited = (0..<5).map { self.visited.contains(Point(x: $0, y: y)) }
            if visited.allSatisfy({ $0 }) {
                return true
            }
        }
        // check columns
        for x in 0..<5 {
            let visited = (0..<5).map { self.visited.contains(Point(x: x, y: $0)) }
            if visited.allSatisfy({ $0 }) {
                return true
            }
        }
        return false
    }

    func calculateScore(winningNumber: Int) -> Int {
        var unmarkedSum = 0
        for (number, location) in self.numbers where !self.visited.contains(location) {
            unmarkedSum += number
        }
        return unmarkedSum * winningNumber
    }
}

let data = try readLines(forDay: 4, omittingEmptySubsequences: false)
let drawnNumbers = data[0].split(separator: ",").map { Int($0)! }
let bingoBoardData = data.dropFirst(2).split(separator: "")

let boards = bingoBoardData.map { boardData -> BingoBoard in
    var numbers = [Int: Point]()
    for (yIdx, row) in boardData.enumerated() {
        let values = row.split(separator: " ")
        for (xIdx, val) in values.enumerated() {
            let number = Int(val)!
            numbers[number] = Point(x: xIdx, y: yIdx)
        }
    }
    return BingoBoard(numbers: numbers)
}

var part1Boards = boards
var foundWinner = false
for number in drawnNumbers {
    for i in 0..<part1Boards.count {
        part1Boards[i].processNumber(number)
        if part1Boards[i].hasWon {
            print("Part 1: \(part1Boards[i].calculateScore(winningNumber: number))")
            foundWinner = true
            break
        }
    }

    if foundWinner { break }
}

var part2Boards = boards
var lastWinner: BingoBoard!
var winningNumber: Int!
for number in drawnNumbers {
    for i in 0..<part2Boards.count {
        part2Boards[i].processNumber(number)
        if part2Boards[i].hasWon {
            lastWinner = part2Boards[i]
            winningNumber = number
        }
    }
    part2Boards = part2Boards.filter { !$0.hasWon }
}

print("Part 2: \(lastWinner.calculateScore(winningNumber: winningNumber))")
