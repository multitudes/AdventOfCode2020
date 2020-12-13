import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day12: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""
	
	func run() throws {
		var input: [String] = []
		if !inputFile.isEmpty {
			let url = URL(fileURLWithPath: inputFile)
			guard let inputFile = try? String(contentsOf: url).lines.compactMap(Int.init) else {fatalError()}
			input = inputFile
		} else {
			print("Running Day12 Challenge with input from the website\n")
			guard let fileURL = Bundle.module.url(forResource: "input", withExtension: "txt") else {
				fatalError("Input file not found")
			}
			guard let inputFile: [String] = try? String(contentsOf: fileURL).components(separatedBy: .whitespacesAndNewlines) else {fatalError()}
			input = inputFile
		}



	}
}

// Run the parser.
Day12.main()


