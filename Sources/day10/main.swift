import Utilities

let data = try readLines(forDay: 10).map { Array($0) }

func getOpeningCharacter(for char: Character) -> Character {
    switch char {
    case "]":
        return "["
    case ")":
        return "("
    case "}":
        return "{"
    case ">":
        return "<"
    default:
        fatalError("Unexpected closing character \(char)")
    }
}

func getClosingCharacter(for char: Character) -> Character {
    switch char {
    case "[":
        return "]"
    case "(":
        return ")"
    case "{":
        return "}"
    case "<":
        return ">"
    default:
        fatalError("Unexpected opening character \(char)")
    }
}

/// Returns the syntax error score for the line, or nil if the line has no syntax errors.
func getSyntaxErrorScore(for line: [Character]) -> Int? {
    var stack = [Character]()
    for char in line {
        switch char {
        case "[", "(", "<", "{":
            stack.append(char)
        case "]", ")", ">", "}":
            guard let match = stack.popLast(), match == getOpeningCharacter(for: char) else {
                switch char {
                case ")":
                    return 3
                case "]":
                    return 57
                case "}":
                    return 1197
                case ">":
                    return 25137
                default:
                    fatalError("Unexpected closing character \(char)")
                }
                continue
            }
        default:
            fatalError("Unexpected character \(char)")
        }
    }
    return nil
}

func getCompletionString(for line: [Character]) -> [Character] {
    var stack = [Character]()
    for char in line {
        switch char {
        case "[", "(", "{", "<":
            stack.append(char)
        case "]", ")", "}", ">":
            _ = stack.popLast()
        default:
            fatalError("Unexpected character \(char)")
        }
    }
    var output = [Character]()
    while let next = stack.popLast() {
        output.append(getClosingCharacter(for: next))
    }
    return output
}

func getCompletionStringScore(for str: [Character]) -> Int {
    var score = 0
    for char in str {
        score *= 5
        switch char {
        case ")":
            score += 1
        case "]":
            score += 2
        case "}":
            score += 3
        case ">":
            score += 4
        default:
            fatalError("Unexpected closing character \(char)")
        }
    }
    return score
}

let part1 = data.compactMap { getSyntaxErrorScore(for: $0) }.reduce(0, +)

// Discard corrupted lines
let validLines = data.filter { getSyntaxErrorScore(for: $0) == nil }

let completionScores = validLines
    .map { getCompletionString(for: $0) }
    .map { getCompletionStringScore(for: $0) }
    .sorted()

let part2 = completionScores[completionScores.count / 2]
print("Part 2: \(part2)")
