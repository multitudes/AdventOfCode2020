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
		print(input[0])
	} catch {
		print(error.localizedDescription)
	}

}


// Run the parser.
Day1.main()

