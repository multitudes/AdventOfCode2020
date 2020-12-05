import ArgumentParser
import Foundation
import AdventKit

// Define our parser.
struct Day6: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""

	func run() throws {
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
			print("Running Day6 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else {
				fatalError("Input file not found")
			}
			let inputString = try String(contentsOf: url)
			input = inputString.components(separatedBy: .newlines)
			input.removeAll { $0.isEmpty }
		}

		let solution = input.map {BoardingPass(binarySpace: $0).seatID}.reduce(0) {max($0, $1)}
		print("\nThe solution for the first challenge is: ", solution)


		let seats = input.map {BoardingPass(binarySpace: $0).seatID}.sorted()

		if let startSeatMap = seats.first, let lastSeat = seats.last {
			let contiguousSet = Set(startSeatMap...lastSeat)
			if let solution2 = contiguousSet.subtracting(Set(seats)).first  {
				print("\nThe solution for the second challenge is: ", solution2, "/n")
			}  else {
				print("No seats available for you!! ")
			}
		}
	}
}

// Run the parser.
Day6.main()


