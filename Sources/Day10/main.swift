import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day10: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""
	
	func run() throws {
		var input: [Int] = []
		
		if !inputFile.isEmpty {
			let url = URL(fileURLWithPath: inputFile)
			guard let inputLines = try? String(contentsOf: url).lines.compactMap(Int.init) else {fatalError()}
			input = inputLines
		} else {
			print("Running Day10 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else {
				fatalError("Input file not found")
			}
			guard let inputLines = try? String(contentsOf: url).lines.compactMap(Int.init) else {fatalError("input not valid")}
			input = inputLines.sorted()
		}

		var jolts: [Int: Int] = [:]
		var previousOutput = 0

		for adapter in input {
			let joltage = adapter-previousOutput
			previousOutput = adapter
			jolts[joltage, default: 0] += 1
		}
		jolts[3, default: 0] += 1
		let jolts3 = jolts[3, default: 0]
		let jolts1 = jolts[1, default: 0]
		//print(jolts.description)

		let solution = jolts1 * jolts3 //1904
		print("Solution part 1: ", solution)


		let currentAdapter = 0
		print(input[currentAdapter+1...currentAdapter+3])
		func checkAdaptersInRange(with currentAdapter: Int) -> Int {
			if currentAdapter == input.last! { return 1 }
			var validSequences = 0
			for adapter in input where adapter - currentAdapter <= 3 {
				if Range(currentAdapter+1...currentAdapter+3) ~= adapter {
					validSequences += checkAdaptersInRange(with: adapter)
				}
			}
			return validSequences
		}

		let solution2 = checkAdaptersInRange(with: currentAdapter)
		print("Solution part 2: ", solution2)
	}

}

// Run the parser.
Day10.main()


