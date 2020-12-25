import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day23: ParsableCommand {
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
			print("Running Day23 Challenge with input from the website\n")
			let inputFile = "389125467"  // example
			//guard let inputFile = "872495136"
			input = inputFile
		}
		print(input)
	}

}


// Run the parser.
Day23.main()


