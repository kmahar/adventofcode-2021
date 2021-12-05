import Foundation
import Utilities

let data = try readLines(forDay: 3).map { Array($0).map { Int(String($0))! } }
let bitCount = data[0].count

func findMostCommonBit(in data: [[Int]], at idx: Int) -> Int {
    var bitBalance = 0
    for line in data {
        switch line[idx] {
        case 0:
            bitBalance -= 1
        case 1:
            bitBalance += 1
        default:
            fatalError("Invalid bit: \(line[idx])")
        }
    }

    return bitBalance < 0 ? 0 : 1
}

func findLeastCommonBit(in data: [[Int]], at idx: Int) -> Int {
    findMostCommonBit(in: data, at: idx) == 0 ? 1 : 0
}

func bitsToInt(_ bits: [Int]) -> Int {
    bits.enumerated().map { idx, bit in
        bit * Int(pow(2, Double(bitCount - 1 - idx)))
    }.reduce(0, +)
}

let gammaBits = (0..<bitCount).map { findMostCommonBit(in: data, at: $0) }
let epsilonBits = (0..<bitCount).map { findLeastCommonBit(in: data, at: $0) }

let gammaValue = bitsToInt(gammaBits)
let epsilonValue = bitsToInt(epsilonBits)
let part1 = gammaValue * epsilonValue

print("Part 1: \(part1)")

var oxygenCandidates = data
var oxygenGeneratorRating: Int!
for i in 0..<bitCount {
    let mostCommonBit = findMostCommonBit(in: oxygenCandidates, at: i)
    oxygenCandidates = oxygenCandidates.filter { $0[i] == mostCommonBit }
    if oxygenCandidates.count == 1 {
        oxygenGeneratorRating = bitsToInt(oxygenCandidates[0])
        break
    }
}

var co2Candidates = data
var co2Rating: Int!
for i in 0..<bitCount {
    let leastCommonBit = findLeastCommonBit(in: co2Candidates, at: i)
    co2Candidates = co2Candidates.filter { $0[i] == leastCommonBit }
    if co2Candidates.count == 1 {
        co2Rating = bitsToInt(co2Candidates[0])
        break
    }
}

let part2 = oxygenGeneratorRating * co2Rating
print("Part 2: \(part2)")
