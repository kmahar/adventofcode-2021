// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "AdventOfCode2021",
    targets: [
        .target(name: "Utilities"),
        .executableTarget(name: "day1", dependencies: ["Utilities"]),
        .executableTarget(name: "day2", dependencies: ["Utilities"]),
        .executableTarget(name: "day3", dependencies: ["Utilities"]),
        .executableTarget(name: "day4", dependencies: ["Utilities"]),
        .executableTarget(name: "day5", dependencies: ["Utilities"]),
        .executableTarget(name: "day6", dependencies: ["Utilities"]),
        .executableTarget(name: "day7", dependencies: ["Utilities"]),
        .executableTarget(name: "day8", dependencies: ["Utilities"]),
        .executableTarget(name: "day9", dependencies: ["Utilities"]),
        .executableTarget(name: "day10", dependencies: ["Utilities"]),
        .executableTarget(name: "day11", dependencies: ["Utilities"]),
        .executableTarget(name: "day12", dependencies: ["Utilities"]),
        .executableTarget(name: "day13", dependencies: ["Utilities"]),
        .executableTarget(name: "day14", dependencies: ["Utilities"]),
        .executableTarget(name: "day15", dependencies: ["Utilities"]),
        .executableTarget(name: "day16", dependencies: ["Utilities"]),
        .executableTarget(name: "day17", dependencies: ["Utilities"]),
        .executableTarget(name: "day18", dependencies: ["Utilities"]),
        .executableTarget(name: "day19", dependencies: ["Utilities"]),
        .executableTarget(name: "day20", dependencies: ["Utilities"]),
        .executableTarget(name: "day21", dependencies: ["Utilities"]),
        .executableTarget(name: "day22", dependencies: ["Utilities"]),
        .executableTarget(name: "day23", dependencies: ["Utilities"]),
        .executableTarget(name: "day24", dependencies: ["Utilities"]),
        .executableTarget(name: "day25", dependencies: ["Utilities"]),
    ]
)
