import ArgumentParser
import Foundation
import AdventKit

// Define our parser.
struct Day9: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""
	
	func run() throws {
		var input: [String] = []
		
		if !inputFile.isEmpty {
			let url = URL(fileURLWithPath: inputFile)
			guard let inputString = try? String(contentsOf: url).lines else {throw RuntimeError("Couldn't read from file!")}
			input = inputString
		} else {
			print("Running Day9 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else {
				fatalError("Input file not found")
			}
			guard let inputLines = try? String(contentsOf: url).lines else {fatalError("input not valid")}
			input = inputLines
		}
		
		
		enum Operation: String, CustomStringConvertible {
			case acc, jmp, nop
			init?(_ rawValue:String) {
				self.init(rawValue:rawValue)
			}
			var description : String { return self.rawValue }
		}
		
		var instructions: [(operation: Operation, argument: Int)] = input.compactMap { line in
			if let capturedGroups = line.getCapturedGroupsFrom(regexPattern: "^(\\w{3}) ([+|-]\\d+)") {
				if let operation = Operation(capturedGroups[0]) {
					return (operation: operation, argument: Int(capturedGroups[1]) ?? 0)
				}}
			return nil
		}
		func runBootCode(bootCode instructions: inout [(operation: Operation, argument: Int)]) -> (infiniteLoop: Bool, accumulator: Int) {
			var visited: [Int: Bool] = [:];	var counter: Int = 0; var accumulator: Int = 0
			while true {
				if counter == instructions.count {
					return (infiniteLoop: false, accumulator: accumulator) }
				if visited[counter] != nil {break} else {visited[counter] = true}
				switch instructions[counter].operation {
					case .nop: counter += 1
					case .acc: accumulator += instructions[counter].argument
						counter += 1
					case .jmp: counter += instructions[counter].argument
				}
			}
			return (infiniteLoop: true, accumulator: accumulator)
		}
		
		var accumulator = runBootCode(bootCode: &instructions).accumulator
		print("Solution part 1: ", accumulator) //1394
		
		// --- part two ---
		
		outerloop : for (key,_)  in instructions.enumerated() {
			var instructionsCopy: [(operation: Operation, argument: Int)] = instructions
			let operation = instructionsCopy[key].operation
			switch operation {
				case .nop: instructionsCopy[key].operation = .jmp
				case .jmp: instructionsCopy[key].operation = .nop
				default: continue
			}
			let result = runBootCode(bootCode: &instructionsCopy)
			if result.infiniteLoop == true {
				continue outerloop } else { accumulator = result.accumulator }
		}
		print("Solution part 2: \(accumulator)")//1626
		
	}
}

// Run the parser.
Day9.main()


