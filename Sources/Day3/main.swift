import ArgumentParser
import Foundation
import AdventKit

// Define our parser.
struct Day3: ParsableCommand {
	// Declare expected launch argument(s).
	//  @Option(help: "Specify an Integer.")
	//  var input: Int

	func run() throws {
		print("Running Day3 Challenge with input from the website\n")
		let startTime = CFAbsoluteTimeGetCurrent()

		let input = getInputArray()
		let stride = (x: 3, y: 1)
		let solution = descend(slope: input, with: stride)
		print("The solution for the first challenge is: ", solution, "\n")

		let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
		let startTime2 = CFAbsoluteTimeGetCurrent()

		let strides: [(Int,Int)] = [(x: 1, y: 1),(x: 3, y: 1),(x: 5, y: 1),(x: 7, y: 1),(x: 1, y: 2)]
		let solution2 = strides.map { descend(slope: input, with: $0)}.reduce(1, *)
		print("The solution for the second challenge is: ", solution2, "\n")
		let timeElapsed2 = CFAbsoluteTimeGetCurrent() - startTime2

		print("Time elapsed for the challenge 1 is: \(timeElapsed, specifier: "%.2f") seconds")
		print(String("Time elapsed for the challenge 2 is: \(timeElapsed2, specifier: "%.2f") seconds"))
	}
}


func getInputArray() -> [String] {
	var input: [String] = []
	do {
		guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else { fatalError("File not found")}
		let inputString = try String(contentsOf: url)
		input = inputString.split(separator: "\n").compactMap {String($0) }
	} catch {
		print(error.localizedDescription)
	}
	return input
}

enum Location: Character {
	case open = "."
	case tree = "#"
	case checkedTree = "🌲"
	case checkedOpen = "⛷"
}

func jump(from position:(x: Int, y: Int), with offset: (x: Int, y: Int)) -> (Int,Int) {
	return (x: position.x + offset.x, y: position.y + offset.y)
}

func descend(slope input: [String] ,with stride: (x: Int, y: Int)) -> Int {
	var trees = 0
	let height = input.count
	var position: (x: Int, y: Int ) = (0,0)

	let start = (0,0)
	var row: [Character]
	while true {
		if position.y >= height { break }
		if position == start {position = jump(from: start, with: stride ); continue}
		row = Array(input[position.y])
		if row[position.x] == Location.open.rawValue {
			row[position.x] = Location.checkedOpen.rawValue
			print(String(row.map {String($0)}.joined()))
		} else if row[position.x] == Location.tree.rawValue {
			row[position.x] = Location.checkedTree.rawValue
			print(String(row.map {String($0)}.joined()))
			trees += 1
		}
		position = jump(from: position, with: stride )
		position.x = (position.x) <= (row.count - 1) ? (position.x) : (position.x - (row.count))
	}

	return trees
}

// Run the parser.
Day3.main()

