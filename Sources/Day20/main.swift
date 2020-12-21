import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day20: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""
	
	func run() throws {
		var input: String = ""
		if !inputFile.isEmpty {
			let url = URL(fileURLWithPath: inputFile)
			guard let inputFile = try? String(contentsOf: url) else {fatalError()}
			input = inputFile
		} else {
			print("Running Day20 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else { fatalError()}
			//guard let url = Bundle.module.url(forResource: "Day17-example", withExtension: "txt") else { fatalError()}

			guard let inputFile = try? String(contentsOf: url) else {fatalError()}
			input = inputFile
		}
		print(input)

		
	}

}


// Run the parser.
Day20.main()


