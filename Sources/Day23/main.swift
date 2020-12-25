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
		//The crab is going to hide your stars - one each - under the two cups that will end up immediately clockwise of cup 1. You can have them if you predict what the labels on those cups will be when the crab is finished.

		//In the above example (389125467), this would be 934001 and then 159792; multiplying these together produces 149245887792.

		input = "389125467"  // test!
		//input = "872495136"
		let inputLabels = Array(input.map {Int(String($0))!})
		print(inputLabels)

		class Cup: Equatable {
			static func == (lhs: Cup, rhs: Cup) -> Bool {
				lhs.label == rhs.label
			}
			init(label: Int) {
				self.label = label
			}
			var label: Int
			var next: Cup?
			var previous: Cup?
		}

		class Cups: CustomStringConvertible {
			var currentCup: Cup?
			var destination: Cup?
			var tail: Cup?
			var cupOne: Cup?
			var cupCount = 0

			init(input: [Int]) {
				for i in 0..<input.count {
					self.append(value: input[i])
				}
				for i in (input.count)...1_000 {
					self.append(value: i )
				}
			}

			public func move() {
			}

			public func cupAt(index: Int) -> Cup? {
			  // index has to be bigger than zero
			  if index >= 0 {
				// I start with head, my current cup
				var cup = currentCup
				var i = index
				// decrementing of i steps until I get
				while cup != nil {
				  if i == 0 {
					//print("return cup at \(index) ")
					return cup }
				  i -= 1
				  cup = cup!.next
				}
			  }
				// not found
			  return nil
			}

			public func append(value: Int) {
				cupCount += 1
				let newCup = Cup(label: value)
				if let lastCup = tail {
					newCup.previous = lastCup
					lastCup.next = newCup
				} else {
					currentCup = newCup
				}
				tail = newCup
			}

			public func contains(_ label: Int) -> Bool {
				var node = currentCup
					while node != nil {
						if node?.label == label { return true }
						node = node!.next
					}
				return false
			}

			public var description: String {
				var text = ""
				var node = currentCup
				for _ in 0..<cupCount {
					text += "\(node!.label)"
					node = node!.next
				}
				return text
			}
		}

		var game = Cups(input: inputLabels)

		game.tail?.next = game.currentCup
		game.currentCup?.previous = game.tail

		func move() {
			print("currentCup \(game.currentCup!.label)")
			game.currentCup?.label
			game.tail?.label
			game.tail?.next?.label
			game.cupAt(index: 0)!.label // currentcup
			game.cupAt(index: 10)!.label // currentcup
			var pickedCupsArray: [Int] = []
			for i in 1...3 {
				pickedCupsArray.append(game.cupAt(index: i)!.label)
			}
			pickedCupsArray
			let threeCups = Cups(input: pickedCupsArray)
			var next = game.cupAt(index: 4)!
			next.label
		//	threeCups.description
		//	threeCups.currentCup?.label //8
		//	threeCups.tail?.label //1

			// make the cut - just taking away the three cups at this stage
			game.currentCup!.next = next
			game.currentCup!.next?.label // 2

			// look for destination cup - (currentLabel - 1) in cups
			var currentLabelMinusOne = game.currentCup!.label - 1
			game.destination = nil
			// first I look in the cups I have from next to the current one
			while true {
				// check my destination is more than zero or I start wrapping the highest
				if currentLabelMinusOne == 0 { currentLabelMinusOne = 1_000 }
				print("looking for", currentLabelMinusOne, "and next is ", next.label)
				// check if currentLabelMinusOne is in picked up cups if so decrease
				if threeCups.cupAt(index: 0)?.label == currentLabelMinusOne || threeCups.cupAt(index: 1)?.label == currentLabelMinusOne || threeCups.cupAt(index: 2)?.label == currentLabelMinusOne {
					print("contained in picked cups!")
					// if found then I decrease
					currentLabelMinusOne -= 1; continue
				}
				// check for destination
				if currentLabelMinusOne == next.label {
					game.destination = next
					print("new destination \(next.label)")
					break
				}
				// here I did one round!
				if game.currentCup == next  {
					print("I did one round!")
					// if not found then I decrease
					currentLabelMinusOne -= 1;
					}
				next = next.next!
			}

			// inserting my threeCups list
			let cut = game.destination!.next
			//print("inserting between \(game.destination!.label) and \(cut!.label)")
			game.destination?.next = threeCups.currentCup
			threeCups.tail?.next = cut

			// new currentcup is right on the next cup
			game.currentCup = game.currentCup?.next
			print("new current cup \(game.currentCup!.label)")
			game.currentCup?.label
		}

		for i in 0..<10 {
		print("-- move \(i + 1) --")
		move()
		}

		let one = game

		var solution = 0
		print("solution ", solution)

	}

}


// Run the parser.
Day23.main()


