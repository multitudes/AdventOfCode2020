import ArgumentParser
import Foundation

// Define our parser.
struct Day1: ParsableCommand {
	// Declare expected launch argument(s).
	//  @Option(help: "Specify an Integer.")
	//  var input: Int

	func run() throws {
		print("Running Day1 Challenge with input from the website\n")
		dayOneFirst()
	}
}


func dayOneFirst() {
	var input: [Int] = []

	do {
		let fileUrl = Bundle.module.url(forResource: "input", withExtension: "txt")!

		let inputString = try String(contentsOf: fileUrl)
		input = inputString.split(separator: "\n").compactMap { Int($0)	}
		//print(input.count)
	} catch {
		print(error.localizedDescription)
	}
	let expensesSorted = input.sorted()
	var j = expensesSorted.count - 1
	var i = 0
	var solution = 0
	while expensesSorted[i] + expensesSorted[j] != 2020 {
		if expensesSorted[i] + expensesSorted[j] < 2020 {
			i += 1
			continue
		}
		if expensesSorted[i] + expensesSorted[j] > 2020 {
			j -= 1
			continue
		}
		if j <= i {break}
	}
	solution = expensesSorted[i] * expensesSorted[j]

	print("The solution for the first challenge Day one is: ", solution, "\n")


}


// Run the parser.
Day1.main()

