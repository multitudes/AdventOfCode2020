import ArgumentParser
import Foundation

// Define our parser.
struct Day1: ParsableCommand {
	// Declare expected launch argument(s).
	//  @Option(help: "Specify an Integer.")
	//  var input: Int

	func run() throws {
		print("Running Day1 Challenge with input from the website\n")
		let input: [Int] = getInputArraySorted()
		dayOneFirstChallenge(input: input)
		dayOneSecondChallenge(input: input)
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
	print("The solution for the first challenge Day one is: ", solution, "\n")
}

func dayOneSecondChallenge(input: [Int] ) {

}

// Run the parser.
Day1.main()

