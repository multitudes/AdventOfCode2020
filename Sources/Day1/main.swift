import ArgumentParser
import Foundation

// Define our parser.
struct Day1: ParsableCommand {
	// Declare expected launch argument(s).
	//  @Option(help: "Specify an Integer.")
	//  var input: Int

	func run() throws {
		let startTime = CFAbsoluteTimeGetCurrent()
		print("Running Day1 Challenge with input from the website\n")
		let input: [Int] = getInputArraySorted()
		dayOneFirstChallenge(input: input)
		let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime


		let startTime2 = CFAbsoluteTimeGetCurrent()
		dayOneSecondChallenge(input: input)
		let timeElapsed2 = CFAbsoluteTimeGetCurrent() - startTime2

		print("\n\nTime elapsed for day one challenge 1 is: \(timeElapsed) s.")
		print("Time elapsed for day one challenge 2 is: \(timeElapsed2) s.\n")
	}
}

func getInputArraySorted() -> [Int] {
	var input: [Int] = []
	do {
		let fileUrl = Bundle.module.url(forResource: "input", withExtension: "txt")!

		let inputString = try String(contentsOf: fileUrl)
		input = inputString.split(separator: "\n").compactMap { Int($0)	}
		//print(input.count)
	} catch {
		print(error.localizedDescription)
	}
	return input.sorted()
}

func dayOneFirstChallenge(input: [Int] ) {
	var j = input.count - 1
	var i = 0
	var solution = 0
	while input[i] + input[j] != 2020 {
		if input[i] + input[j] < 2020 {
			i += 1
			continue
		}
		if input[i] + input[j] > 2020 {
			j -= 1
			continue
		}
		if j <= i {break}
	}
	solution = input[i] * input[j]
	print("The solution for the first challenge is: ", solution, "\n")
}

func dayOneSecondChallenge(input: [Int] ) {

	var j = input.count - 1
	var i = 0
	var k = 1
	let limit = 2020
	var solution = 0

	outerloop: while input[i] + input[j] + input[k] != limit {

		if j <= i { break }
		if input[i] + input[j] < limit {
			let sumFirstTwoExpenses = input[i] + input[j]

			if k == i { k += 1 } else { k = 0 }
			while true {
				if k >= input.count - 1 { break }
				if sumFirstTwoExpenses + input[k] == limit {
					solution = input[i] * input[j] * input[k]
					print("The solution for the second challenge is: ", solution, "\n")
					break outerloop
				}
				if sumFirstTwoExpenses + input[k] < limit {
					k += 1
					continue
				}
				if sumFirstTwoExpenses + input[k] > limit {
					k = 0; j -= 1; i -= 1
					break
				}
			}
			i += 1
			continue
		}
		j -= 1
	}
}

// Run the parser.
Day1.main()

