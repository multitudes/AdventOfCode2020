import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day19: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""
	
	func run() throws {
		var input: [Array<String>.SubSequence] = []
		if !inputFile.isEmpty {
			let url = URL(fileURLWithPath: inputFile)
			guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}
			input = inputFile.split {$0 == "" }
		} else {
			print("Running Day17 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input2", withExtension: "txt") else { fatalError()}
			guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}
			input = inputFile.split {$0 == "" }
		}
		print(input)

		let rules = input[0]
		let messages = input[1]
		var rulesDict: [Int: String] = [:]

		for rule in rules {
			if let regex = rule.getCapturedGroupsFrom(regexPattern: "(\\d+):[ \"]{1,2}(\\w)[\"]{1}") {
				let key = Int(regex[0])!
				let expr = " " + regex[1] + " "
				rulesDict[key] = expr
				print("key, expr", key, expr)
			} else if let regex = rule.getCapturedGroupsFrom(regexPattern: "(\\d+):(.+)") {
				let key = Int(regex[0])!
				var expr = regex[1]
				expr = ("(" + expr + " )")
				print("key, expr", key, expr)
				rulesDict[key] = expr
			}
		}
		var resolvedDict: [Int: Int] = [:]
		func createRegex(from ruleZero: String) -> String {
			let arrayRules = ruleZero.split(separator: " ").map {String($0)}
			var regexPattern = arrayRules
			for (idx,rule) in arrayRules.enumerated() {
				if rule == "(" || rule == ")" || rule == "a" || rule == "b" || rule == "|" {continue}
				print("rules",rule)
				let keyRule = Int(String(rule))!
				print("keyRule",keyRule)
				if let itemToResolve = rulesDict[keyRule] {
					print(itemToResolve)
					if itemToResolve == " a " || itemToResolve == " b " {
						regexPattern[idx] = itemToResolve
						continue
					} else if resolvedDict[keyRule, default: 0] < 200 {
						print("resolvedDict[\(keyRule), default: 0] ", resolvedDict[keyRule, default: 0] )
						resolvedDict[keyRule, default: 0] += 1
						regexPattern[idx] = itemToResolve
					} else {
						print("skipped     ------ ", keyRule)
					}
				}
			}
			return regexPattern.joined(separator: " ")
		}

		var regexPattern = (rulesDict[0] ?? "")
		//while !regexPattern.allSatisfy({"ab()| ".contains($0)}) {
		for i in 0..<5{
		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)
		regexPattern = createRegex(from: regexPattern)
		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)
		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)
		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)
		regexPattern = createRegex(from: regexPattern)
regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)
		regexPattern = createRegex(from: regexPattern)
		regexPattern = createRegex(from: regexPattern)
		regexPattern = createRegex(from: regexPattern)
		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)
		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)
		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)
		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)

		regexPattern = createRegex(from: regexPattern)
		}
		//}
		print(regexPattern)


		regexPattern = "^" + regexPattern.replacingOccurrences(of:" ", with: "") + "$"
		guard let regex = try? NSRegularExpression(pattern: regexPattern) else { fatalError("invalid regex expression \n") }
		var count = 0
		for message in messages {
			let range = NSRange(location: 0, length: message.utf16.count)
			if regex.firstMatch(in: message, options: [], range: range) != nil { count += 1}
		}
		print("Solution part one : ", count)

	}
}


// Run the parser.
Day19.main()


