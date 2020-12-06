import ArgumentParser
import Foundation
import AdventKit

// Define our parser.
struct Day6: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""

	func run() throws {
		var input: String = ""

		if !inputFile.isEmpty {
				let url = URL(fileURLWithPath: inputFile)
				guard let inputString = try? String(contentsOf: url) else {throw RuntimeError("Couldn't read from file!")}
				input = inputString
		} else {
			print("Running Day6 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else {
				fatalError("Input file not found")
			}
			guard let inputString = try? String(contentsOf: url) else {fatalError()}
			input = inputString
		}
		let groups = input.split(omittingEmptySubsequences: false, whereSeparator: \.isWhitespace)
		// ["abc", "", "a", "b", "c", "", "ab", "ac", "", "a", "a", "a", "a", "", "b"]
		let forms = groups.split(whereSeparator: { $0.isEmpty}).map {Array($0).map {Array($0)} }
		// [ArraySlice(["abc"]), ArraySlice(["a", "b", "c"]), ArraySlice(["ab", "ac"]) ...
		let sets = forms.map {Set($0) }
		//[Set([["a", "b", "c"]]), Set([["a"], ["c"], ["b"]]), Set([["a", "c"], ["a", "b"]]), Set([["a"]]), Set([["b"]])]

		let solution = sets.map {Set($0.reduce([], +)).count}.reduce(0, +)
		print("\nThe solution for the first challenge is: ", solution)

		let solution2 = sets.reduce(0) { sum, set in
			let intersection = set.reduce(Set(set.first!)) { res,subSet in
				res.intersection(subSet) }
			return sum + intersection.count
		}
		print("\nThe solution for the second challenge is: ", solution2)
	}
}

// Run the parser.
Day6.main()


