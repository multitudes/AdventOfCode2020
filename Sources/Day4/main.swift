import ArgumentParser
import Foundation
import AdventKit

// Define our parser.
struct Day4: ParsableCommand {
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
			print("Running Day4 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else { fatalError("File not found")}
			input = getInputArray(from: url)
		}

		let solution = ""

		let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
		let startTime2 = CFAbsoluteTimeGetCurrent()

		let solution2 = ""
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


// Run the parser.
Day4.main()

struct RuntimeError: Error, CustomStringConvertible {
	var description: String

	init(_ description: String) {
		self.description = description
	}
}
