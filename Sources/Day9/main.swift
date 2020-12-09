import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day9: ParsableCommand {
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
			print("Running Day9 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else {
				fatalError("Input file not found")
			}
			guard let inputLines = try? String(contentsOf: url).lines.compactMap(Int.init) else {fatalError("input not valid")}
			input = inputLines
		}
		func checkForRange(with invalidNumber: Int) -> Int? {
			for i in 0..<count {
				var partialSum = 0
				var subSequence: Array<Int>.SubSequence = []
				runningIndex = i
				if input[runningIndex] + input[runningIndex + 1] == invalidNumber {
					return input[runningIndex] + input[runningIndex + 1]
				}
				if input[runningIndex] + input[runningIndex + 1] > invalidNumber {
					continue
				}
				while runningIndex < count - 1 {
					let currentNumber = input[runningIndex]
					runningIndex += 1; partialSum += currentNumber
					subSequence.append(currentNumber)
					if partialSum >  invalidNumber { break	}
					if partialSum == invalidNumber {
						if subSequence.count == 1 { continue }
						return subSequence.sorted().first! + subSequence.sorted().last!
					}
				}
			}
			return nil
		}
		//check the workingQ is valid!
		func checksums(queue: Array<Int>.SubSequence, with next: Int) -> (isValid:Bool, solution: Int? ) {
			let q = queue.sorted()
			print("working queue sorted ", q)
			let lastIndex = q.count - 1
			var first:Int = 0; var last: Int = lastIndex
			let lasttwosum = q[lastIndex] + q[lastIndex-1]
			if lasttwosum < next {
				print("Error // solution is ",next); return (false, next) }

			while first < last {
				let sum = q[first] + q[last]
				switch sum  {
					case next :
						print("q is ok /// ")
						return (true, nil)
					case (..<next) :
						first += 1
						continue
					default:
						last -= 1
						continue
				}
			}
			print("Error // solution is ",next)
			return (false, next)
		}

		let preamble = 25
		var workingQueue = input.prefix(preamble)
		var runningIndex = preamble
		let count = input.count

		var solution1 = 0
		var solution2 = 0

		while runningIndex < count {
			let next = input[runningIndex]
			print("workingQueue", workingQueue, " next ", next)

			if checksums(queue: workingQueue, with: next).isValid { // (true, nil)
				print("ok")
			} else {
				print("ok", next, ">>>>>>>>>>>>>>>>>>>>>>>>")
				solution1 = next
				if let solution = checkForRange(with: next)  { print("Solution2 ! ")
					solution2 = solution
				}
				break
			}
			workingQueue = workingQueue.dropFirst()
			workingQueue.append(next)
			runningIndex += 1
		}

		print("Solution part 1: ", solution1) //18272118
		print("Solution part 2: ", solution2) // 2186361
	}
}

// Run the parser.
Day9.main()


