import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day16: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""
	
	func run() throws {


		print("Solution part 1: ") //1065
		print("Solution part 2: ") // 1065

	}
}

// Run the parser.
Day16.main()


