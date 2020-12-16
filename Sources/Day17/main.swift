import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day15: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""
	
	func run() throws {


		//let inputExample1 = [0,3,6]

		//let input = [14,3,1,0,9,5]

		let startingNumbers = [14,3,1,0,9,5]

		let inputIndices = startingNumbers.indices.map {$0 + 1}
		// the key is the spoken number / the value is the last index seen
		let tuples = zip(startingNumbers, inputIndices)
		let inputDict: [Int: Int] = Dictionary(uniqueKeysWithValues: tuples)
		var visitedNumbers: [Int: (idx: Int, previousIdx: Int?)] = inputDict.mapValues { value in
			(idx: value, previousIdx: nil)
		}
		var idx = inputIndices.count
		var last = startingNumbers[idx - 1]

		func speakNumber() {
			idx += 1
			if let visited = visitedNumbers[last] {
				if let previousIdx = visited.previousIdx {
					last = visited.idx - previousIdx
					if let visitedAge = visitedNumbers[last] {
						visitedNumbers[last] = (idx: idx, previousIdx: visitedAge.idx)
					} else {
						visitedNumbers[last] = (idx: idx, previousIdx: nil)
					}
				} else {
					last = 0;
					if let visitedZero = visitedNumbers[0] {
						visitedNumbers[0] = (idx: idx, previousIdx: visitedZero.idx)
					}
				}
			}
		}

		while idx < 30000000 {

			speakNumber()
			if idx == 2020 {print("solution part 1: ", last)} //1065
		}
		print("Solution part 2: ", last) // 1065

	}
}

// Run the parser.
Day15.main()


