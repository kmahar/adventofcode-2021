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
        .executableTarget(name: "day11"),
        .executableTarget(name: "day12"),
        .executableTarget(name: "day13"),
        .executableTarget(name: "day14"),
        .executableTarget(name: "day15"),
        .executableTarget(name: "day16"),
        .executableTarget(name: "day17"),
        .executableTarget(name: "day18"),
        .executableTarget(name: "day19"),
        .executableTarget(name: "day20"),
        .executableTarget(name: "day21"),
        .executableTarget(name: "day22"),
        .executableTarget(name: "day23"),
        .executableTarget(name: "day24"),
        .executableTarget(name: "day25"),
    ]
)
