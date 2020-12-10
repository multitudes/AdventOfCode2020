import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day10: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""
	
	func run() throws {
		var url = URL(string: "")
		if !inputFile.isEmpty {
			let url = URL(fileURLWithPath: inputFile)
		} else {
			print("Running Day10 Challenge with input from the website\n")
			guard let fileURL = Bundle.module.url(forResource: "input", withExtension: "txt") else {
				fatalError("Input file not found")
			}
			url = fileURL
		}

		enum AdventError: Error {case fileNotFound, fileNotValid}

		struct FileLinesIterator: IteratorProtocol {
			let lines: [Int]
			var currentLine: Int = 0
			init(url: URL) throws {
				let contents: String = try String(contentsOf: url)
				lines = contents.lines.compactMap(Int.init).sorted()
			}
			mutating func next() -> Int? {
				guard currentLine < lines.endIndex else { return nil }
				defer {currentLine += 1}
				return lines[currentLine]
			}
		}

		var input = try? FileLinesIterator(url: url!)
		var accumulator = 1
		var partial: Int? = nil
		var jolts: [Int: Int] = [:]
		var previousOutput = 0
		while true {
			if let adapter = input?.next() {
				let joltage = adapter-previousOutput
				previousOutput = adapter
				jolts[joltage, default: 0] += 1
				// part 2
				if joltage == 3 {accumulator *= partial ?? 1; partial = nil}
				if joltage == 1 {
					if partial == nil {partial = 1; continue}
					if partial == 1 {partial = 2; continue}
					if partial! == 2 {partial! += 2; continue}
					if partial! == 4 {partial! += 3; continue}
				}
				continue
			}
			let jolts1 = jolts[1, default: 0]
			let jolts3 = jolts[3, default: 0] + 1

			let solution = jolts1 * jolts3 //1904
			let solution2 = accumulator * (partial ?? 1) //10578455953408
			break
		}

		var currentAdapter = 0
		let inputSet = Set(input)
		func checkAdaptersInRange(with currentAdapter: Int) -> Int {
			if currentAdapter == input.max()! { return 1 }
			var validSequences = 0
			for i in Range(1...3) {
				if inputSet.contains(currentAdapter + i) {
					validSequences += checkAdaptersInRange(with: currentAdapter + i)
				}
			}
			return validSequences
		}

		let solution2 = checkAdaptersInRange(with: currentAdapter)
		print(solution2)
	}

}

// Run the parser.
Day10.main()


