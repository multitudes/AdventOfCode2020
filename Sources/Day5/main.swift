import ArgumentParser
import Foundation
import AdventKit

// Define our parser.
struct Day5: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""

	func run() throws {
		let startTime = CFAbsoluteTimeGetCurrent()
		var input: [String] = []

		if !inputFile.isEmpty {
			do {
				let url = URL(fileURLWithPath: inputFile)
				input = try String(contentsOf: url).components(separatedBy: .newlines)
				input.removeAll { $0.isEmpty }
			} catch  {
				throw RuntimeError("Couldn't read from file!")
			}
		} else {
			print("Running Day5 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else {
				fatalError("Input file not found")
			}
			let inputString = try String(contentsOf: url)
			input = inputString.components(separatedBy: .newlines)
			input.removeAll { $0.isEmpty }
		}

		let seats = input.map {BoardingPass($0).seatID}
		let solution1 = input.map {BoardingPass(binarySpace: $0).seatID}.reduce(0) {max($0, $1)}
		print("\nThe solution for the first challenge is: ", solution1)

		let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
		let startTime2 = CFAbsoluteTimeGetCurrent()

		let minSeatNumber = input.map {BoardingPass($0).seatID}.reduce(0) {min($0, $1)}
		let maxSeatNumber = solution1
		let contiguousSet = Set(minSeatNumber...maxSeatNumber)
		if let solution2 = contiguousSet.subtracting(Set(seats)).first  {
			print("solution part 2 is \(solution2)")
		}  else {
			print("No seats available for you!! ")
		}

		print("\nTime elapsed for the challenge 1 is: \(timeElapsed, specifier: "%.2f") seconds")
		print(String("Time elapsed for the challenge 2 is: \(timeElapsed2, specifier: "%.2f") seconds"))
	}
}

// Run the parser.
Day5.main()


