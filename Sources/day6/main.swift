import Utilities

let data = try readLines(forDay: 6)[0].split(separator: ",").map { Int($0)! }

func runSimulation(data: [Int], days: Int) -> Int {
    // track number of fish at each life cycle stage.
    var latestFishStages = [Int: Int]()
    for fish in data {
        latestFishStages[fish] = latestFishStages[fish, default: 0] + 1
    }

    for _ in 1...days {
        var newFishStages = [Int: Int]()
        // all fish with timer values 1-8 decrease timer by one.
        for i in 1...8 {
            newFishStages[i - 1] = latestFishStages[i, default: 0]
        }
        // all fish at timer 0 transition back to timer 6.
        newFishStages[6]! += latestFishStages[0, default: 0]
        // for each fish we reset the timer for, add a new fish at timer 8.
        newFishStages[8] = latestFishStages[0, default: 0]

        latestFishStages = newFishStages
    }
    return latestFishStages.reduce(0) { $0 + $1.value }
}

print("Part 1: \(runSimulation(data: data, days: 80))")
print("Part 2: \(runSimulation(data: data, days: 256))")
