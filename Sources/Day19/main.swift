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
			print("Running Day19 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else { fatalError()}
			guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}
			input = inputFile.split {$0 == "" }
		}
		//print(input)

		let rules = input[0]
		let messages = input[1]
		var rulesDict: [Int: String] = [:]

		for rule in rules {
			if let regex = rule.getCapturedGroupsFrom(regexPattern: "(\\d+):[ \"]{1,2}(\\w)[\"]{1}") {
				let key = Int(regex[0])!
				let expr = " " + regex[1] + " "
				rulesDict[key] = expr
			} else if let regex = rule.getCapturedGroupsFrom(regexPattern: "(\\d+):(.+)") {
				let key = Int(regex[0])!
				var expr = regex[1]
				expr = ("(" + expr + " )")//.replacingOccurrences(of: " ", with: "")
				rulesDict[key] = expr
			}
		}

		func createRegex(from ruleZero: String) -> String {
			let arrayRules = ruleZero.split(separator: " ").map {String($0)}
			var regexPattern = arrayRules
			for (idx,rule) in arrayRules.enumerated() {
				if rule == "(" || rule == ")" || rule == "a" || rule == "b" || rule == "|" {continue}
				print("rules",rule)
				if let itemToResolve = rulesDict[Int(String(rule))!] {
					print(itemToResolve)
					regexPattern[idx] = itemToResolve
				}
			}
			return regexPattern.joined(separator: " ")
		}

		var regexPattern = (rulesDict[0] ?? "")
		while !regexPattern.allSatisfy({"ab()| ".contains($0)}) {
			regexPattern = createRegex(from: regexPattern)
		}
		print(regexPattern)
		regexPattern = "^" + regexPattern.replacingOccurrences(of:" ", with: "") + "$"
		guard let regex = try? NSRegularExpression(pattern: regexPattern) else { fatalError("invalid regex expression \n") }
		var count = 0
		for message in messages {
			let range = NSRange(location: 0, length: message.utf16.count)
			if regex.firstMatch(in: message, options: [], range: range) != nil { count += 1}
		}
		print("Solution part one : ", count)

		regexPattern = (rulesDict[42] ?? "")
		print(regexPattern)
		while !regexPattern.allSatisfy({"ab()| ".contains($0)}) {
		regexPattern = createRegex(from: regexPattern)
		}
		let regexPattern42First = regexPattern  + "{1,}"
		let regexPattern42Second = regexPattern  + "{x}"

		regexPattern = (rulesDict[31] ?? "")
		while !regexPattern.allSatisfy({"ab()| ".contains($0)}) {
		regexPattern = createRegex(from: regexPattern)
		}
		let regexPattern31 = regexPattern  + "{x}"

		regexPattern = regexPattern42First + regexPattern42Second + regexPattern31
		print(regexPattern)
		let regexPatternX = "^" + regexPattern.replacingOccurrences(of:" ", with: "") + "$"
		regexPattern = regexPatternX.replacingOccurrences(of:"x", with: "1")
		print(regexPattern)

		guard let regexPartTwo = try? NSRegularExpression(pattern: regexPattern) else { fatalError("invalid regex expression \n") }
		count = 0
		for message in messages {
			let range = NSRange(location: 0, length: message.utf16.count)
			if regexPartTwo.firstMatch(in: message, options: [], range: range) != nil {
				count += 1
				continue
			}
			else {
				for i in 2...6 {
					//print("alternative regex!! ===== \n\n")
					let regexPattern2 = regexPatternX.replacingOccurrences(of:"x", with: String(i))
					guard let regex2 = try? NSRegularExpression(pattern: regexPattern2) else { fatalError("invalid regex expression \n") }
					if regex2.firstMatch(in: message, options: [], range: range) != nil {
						count += 1
						continue
					}
				}
			}
		}


		print("Solution part two : ", count)

	}
}


// Run the parser.
Day19.main()


