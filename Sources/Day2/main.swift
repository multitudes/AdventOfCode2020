import ArgumentParser
import Foundation
import AdventKit

// Define our parser.
struct Day2: ParsableCommand {
	// Declare expected launch argument(s).
	//  @Option(help: "Specify an Integer.")
	//  var input: Int

	func run() throws {
		print("Running Day2 Challenge with input from the website\n")
		let startTime = CFAbsoluteTimeGetCurrent()

		let input = getInputArray()
		let solution = input.filter { Password($0)?.isValid ?? false}.count
		print("The solution for the first challenge is: ", solution, "\n")

		let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
		let startTime2 = CFAbsoluteTimeGetCurrent()

		let solution2 = input.filter { Password($0)?.isValidForNewPolicy ?? false }.count
		print("The solution for the second challenge is: ", solution2, "\n")
		let timeElapsed2 = CFAbsoluteTimeGetCurrent() - startTime2

		print("Time elapsed for the challenge 1 is: \(timeElapsed, specifier: "%.2f") seconds")
		print(String("Time elapsed for the challenge 2 is: \(timeElapsed2, specifier: "%.2f") seconds"))
	}
}


func getInputArray() -> [String] {
	var input: [String] = []
	do {
		let fileUrl = Bundle.module.url(forResource: "input", withExtension: "txt")!

		let inputString = try String(contentsOf: fileUrl)
		input = inputString.split(separator: "\n").compactMap {String($0)}
	} catch {
		print(error.localizedDescription)
	}
	return input
}

// Run the parser.
Day2.main()

