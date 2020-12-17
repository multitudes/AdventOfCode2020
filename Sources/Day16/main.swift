import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day16: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""

	func run() throws {
		var input: [String] = []
		if !inputFile.isEmpty {
			let url = URL(fileURLWithPath: inputFile)
			guard let inputFile = try? String(contentsOf: url).components(separatedBy: .whitespacesAndNewlines) else {fatalError()}
			input = inputFile
		} else {
		print("Running Day16 Challenge with input from the website\n")
		guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else { fatalError()}
		guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}
		input = inputFile
		}
		//conditions ["class: 1-3 or 5-7", "row: 6-11 or 33-44", "seat: 13-40 or 45-50"]
		let conditions = input.split { $0 == "your ticket:"}[0]

		// ["7,1,14", "nearby tickets:", "7,3,47", ... ]
		let tickets = Array(input.split { $0 == "your ticket:"}[1])

		// [7, 1, 14]
		let myTicket = tickets[0].split(separator: ",").compactMap { Int($0)}
		print("myTicket",myTicket) // [7, 1, 14...]

		// [[7, 3, 47], [40, 4, 50], [55, 2, 20], [38, 6, 12]]
		let nearbyTickets = tickets.split { $0 == "nearby tickets:"}[1].map {$0.split(separator: ",").compactMap { Int($0)}}.filter {$0 != []}

		//print("conditions", conditions)
		//print("myTicket", myTicket)
		//print("Nearby Tickets", nearbyTickets)

		// create dictionary
		var rules: [String: Set<Int>] = [:]
		for condition in conditions {
			if let field = condition.getCapturedGroupsFrom(regexPattern: "^([\\w ]+): (\\d+)-(\\d+) or (\\d+)-(\\d+)$") {
				let fieldName = field[0]; let a = Int(field[1])!; let b = Int(field[2])!; let c = Int(field[3])!; let d = Int(field[4])!;
				let set1 = Set(a...b); let set2 = Set(c...d)
				rules[fieldName] = set1.union(set2)
			}
		}

		func checkFieldKeyContains(value: Int, key: String) -> Bool {
			let set = rules[key]!
			if set.contains(value) {
				return true
			}
			return false
		}
		//
		func returnNotValid(in ticket: [Int]) -> Int {
			var notValid: [Int] = []
			outerloop : for fieldValue in ticket {
				//print(fieldValue)
				for key in rules.keys {
					//print(key)
					if checkFieldKeyContains(value: fieldValue, key: key) {
						continue outerloop
					}
				}
				notValid.append(fieldValue)
			}
			//print(notValid)
			return notValid.reduce(0,+)
		}

		var validTickets: [[Int]] = []
		var solution = 0

		nearbyTickets.forEach {
			let notValid = returnNotValid(in: $0)
			if notValid != 0 { solution += notValid	} else
			{validTickets.append($0)}
		}
		print("Solution part 1: ",solution) //25916

		// --- part two --- got the valid tickets now

		func checkFieldKeyContains(set: Set<Int>, key: String) -> Bool {
			let setFromRules = rules[key]!
			if setFromRules.isSuperset(of: set) {
				return true
			} else {return false}
		}


		print(rules.keys)
		var valuesPerIndex: [Int: Set<Int>] = [:]
		var dictOfMatchingRulesAndIndices: [String: Set<Int>] = [:]

		for idx in 0..<myTicket.count {

			print("index ", idx)
			for ticket in validTickets {
				var field = valuesPerIndex[idx, default: []]
				field.insert(ticket[idx])
				valuesPerIndex[idx] = field
			}
			print("sequence filled", valuesPerIndex[idx]!, valuesPerIndex[idx]!.count ,  "=======\n")

			// what is this sequence matching?
			var matchingRules: Set<Int> = []
			for key in rules.keys {
				print(key)
				if checkFieldKeyContains(set: valuesPerIndex[idx]! , key: key) {
					print(key, "contains", idx)
					matchingRules = dictOfMatchingRulesAndIndices[key, default: []]
					matchingRules.insert(idx)
					dictOfMatchingRulesAndIndices[key] = matchingRules
				}
			}
			//print("dictOfMatchingFieldsAndIndices",dictOfMatchingRulesAndIndices)
		}
		print("dictOfMatchingFieldsAndIndices",dictOfMatchingRulesAndIndices)
		var sortedByValuetuples = dictOfMatchingRulesAndIndices.sorted { $0.1.count < $1.1.count}

		print(sortedByValuetuples)//[(key: "seat", value: Set([2])), (key: "class", value: Set([1, 2])), (key: "row", value: Set([0, 1, 2]))]

		print("sortedByValuetuples.count", sortedByValuetuples.count)

		for idx in 0..<sortedByValuetuples.count {
			print("idx ================= ", idx)

			if sortedByValuetuples[idx].value.count == 1 {
				let value = sortedByValuetuples[idx].value.first!
				print("value ", value)
				for kdx in (idx+1)..<sortedByValuetuples.count {
					if sortedByValuetuples[kdx].value.contains(value) {
						print("contains \(value)")
						let valueSet: Set<Int> = [value]
						//print("valueSet ", valueSet)
						sortedByValuetuples[kdx].value.subtract(valueSet)
						print(sortedByValuetuples[kdx].value)
					}
				}
			}
		}
		print(sortedByValuetuples.description)
		print(sortedByValuetuples)
//		print("Solution part 1: ",solution) //
//		print("Solution part 2: ") //

	}
}

// Run the parser.
Day16.main()


