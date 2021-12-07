import Utilities

let crabs = try readLines(forDay: 7)[0].split(separator: ",").map { Int($0)! }
let minPos = crabs.min()!
let maxPos = crabs.max()!

var fuelCostsPart1 = [Int: Int]()
for x in minPos...maxPos {
    fuelCostsPart1[x] = crabs.map { abs($0 - x) }.reduce(0, +)
}

let minCost1 = fuelCostsPart1.values.min()!
print("Part 1: \(minCost1)")

var fuelCostsPart2 = [Int: Int]()
for x in minPos...maxPos {
    fuelCostsPart2[x] = crabs.map { crab in
        let dist = abs(crab - x)
        // use formula for sum of first n numbers: n(n+1)/2
        let fuelCost = dist * (dist + 1) / 2
        return fuelCost
    }.reduce(0, +)
}

let minCost2 = fuelCostsPart2.values.min()!
print("Part 2: \(minCost2)")
