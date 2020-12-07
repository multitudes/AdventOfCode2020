import ArgumentParser
import Foundation
import AdventKit

// Define our parser.
struct Day7: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""

	func run() throws {
		var input: String = ""

		if !inputFile.isEmpty {
				let url = URL(fileURLWithPath: inputFile)
				guard let inputString = try? String(contentsOf: url) else {throw RuntimeError("Couldn't read from file!")}
				input = inputString
		} else {
			print("Running Day7 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else {
				fatalError("Input file not found")
			}
			guard let inputString = try? String(contentsOf: url) else {fatalError()}
			input = inputString
		}
		let solution = 0
		print("\nThe solution for the first challenge is: ", solution)

		let solution2 = 0
		print("\nThe solution for the second challenge is: ", solution2)
	}
}

// Run the parser.
Day7.main()


