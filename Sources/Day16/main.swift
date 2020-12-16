import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day16: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""

	

	func run() throws {



		print("Solution part 1: "
			  ,2**3) //
		print("Solution part 2: ") //

	}
}

// Run the parser.
Day16.main()


