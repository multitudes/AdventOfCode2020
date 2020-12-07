import ArgumentParser
import Foundation
import AdventKit

// Define our parser.
struct Day7: ParsableCommand {
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
			print("Running Day7 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else {
				fatalError("Input file not found")
			}
			guard let inputString = try? String(contentsOf: url) else {fatalError("input not valid")}
			input = inputString
		}

		var rules = input.lines.compactMap {$0.trimmingCharacters(in: .punctuationCharacters)}

		var rulesDict: [String: [String]] = [:]
		rules.forEach {
			if let groups = $0.getCapturedGroupsFrom(regexPattern:"([a-z ]+)bags? contain (.+)") {
				let bagRule = groups[0].trimmingCharacters(in: .whitespaces)
				let contents = groups[1].split(separator: ",").map {String($0).trimmingCharacters(in: .whitespaces)}
				//print("contents ", contents)
				for content in contents {
					//print("contentof contents ----------",bagRule,content)
					if let data = content.getCapturedGroupsFrom(regexPattern:"(\\d) (\\w+ \\w+) bags?") {

						let arrayBags = [data[1]]
						//print(arrayBags)
						rulesDict[bagRule, default: []] += arrayBags
						//print(rulesDict.debugDescription)
					}
					if let _ = content.getCapturedGroupsFrom(regexPattern:"(no other) bags") {
						rulesDict[bagRule, default: []] = []
						//print(data)
					}

				}
			}
		}

		var cache = [String:Bool]()
		func containsRecursively(bag: String, in dict: [String:[String]]) -> Bool {
			if bag == "shiny gold" {return true}

			if let res = cache[bag] {print("\ncached!! \(bag)\n");return res}
			let bags = dict[bag] ?? []

			for bag in bags {
				//print("recursion =======", bag)
				if containsRecursively(bag: bag, in: dict) == true {
					return true
				}
				cache[bag] = false
			}
			return false
		}

		var solution: [String] = []
		//rulesDict["shiny gold"] = nil
		for key in rulesDict.keys {
			if key == "shiny gold" { continue }
			print("key", key, rulesDict[key]!)
			if containsRecursively(bag: key, in: rulesDict) == true {
				solution.append(key)
			}
		}
		
		print("\nThe solution for the first challenge is: ", solution.count)

		let solution2 = 0
		print("\nThe solution for the second challenge is: ", solution2)
	}
}

// Run the parser.
Day7.main()


