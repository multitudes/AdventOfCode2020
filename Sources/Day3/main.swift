import ArgumentParser
import Foundation
import AdventKit

// Define our parser.
struct Day3: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""

	func run() throws {
		let startTime = CFAbsoluteTimeGetCurrent()
		var input: [String] = []

		if !inputFile.isEmpty {
			do {
				let url = URL(fileURLWithPath: inputFile)
				input = try String(contentsOf: url).split(separator: "\n").compactMap {String($0) }
			} catch  {
				throw RuntimeError("Couldn't read from file!")
			}
		} else {
			print("Running Day3 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else { fatalError("File not found")}
			input = getInputArray(from: url)
		}

		let stride = (x: 3, y: 1)
		let solution = descend(slope: input, with: stride)

		let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
		let startTime2 = CFAbsoluteTimeGetCurrent()

		let strides: [(Int,Int)] = [(x: 1, y: 1),(x: 3, y: 1),(x: 5, y: 1),(x: 7, y: 1),(x: 1, y: 2)]
		let solution2 = strides.map { descend(slope: input, with: $0)}.reduce(1, *)
		print("\nThe solution for the first challenge is: ", solution)
		print("The solution for the second challenge is: ", solution2, "\n")
		let timeElapsed2 = CFAbsoluteTimeGetCurrent() - startTime2

		print("Time elapsed for the challenge 1 is: \(timeElapsed, specifier: "%.2f") seconds")
		print(String("Time elapsed for the challenge 2 is: \(timeElapsed2, specifier: "%.2f") seconds"))
	}
}


func getInputArray(from url: URL) -> [String] {
	var input: [String] = []
	do {
		input = try String(contentsOf: url).split(separator: "\n").compactMap {String($0) }
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
	var position: (x: Int, y: Int ) = (0,0)
	var row: [Character]

	while position.y < input.count {
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
		position.x = position.x % row.count
	}
	return trees
}

// Run the parser.
Day3.main()

struct RuntimeError: Error, CustomStringConvertible {
	var description: String

	init(_ description: String) {
		self.description = description
	}
}
