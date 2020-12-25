import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day22: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""
	
	func run() throws {
		var input: [[String]] = []
		if !inputFile.isEmpty {
			let url = URL(fileURLWithPath: inputFile)
			guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}
			input = inputFile.split {$0 == "" }.map {Array($0) }
		} else {
			print("Running Day22 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else { fatalError()}
			//guard let url = Bundle.module.url(forResource: "Day22-example", withExtension: "txt") else { fatalError()}

			guard let inputFile = try? String(contentsOf: url).lines else {fatalError()}
			input = inputFile.split {$0 == "" }.map {Array($0) }
		}

		print(input)

		// init
		var one = input[0].compactMap {Int($0)}
		var two = input[1].compactMap {Int($0)}

		while !one.isEmpty && !two.isEmpty {
			func playRound() {
				let topOne = one.remove(at: 0); let topTwo = two.remove(at: 0)
				if topOne > topTwo {
					one.append(contentsOf: [topOne, topTwo])
				} else {
					two.append(contentsOf: [topTwo, topOne])
				}
			}
			playRound()
		}

		var range = Range(1...two.count).reversed()
		let sol = zip(range, two).reduce(0) { $0 + $1.0 * $1.1 }

		print("Solution part one : ", sol)

		// start new game
		// init
		one = input[0].compactMap {Int($0)}
		two = input[1].compactMap {Int($0)}

		var game = 0
		var winningDeck: [Int] = []
		func playGame(deck1 one: [Int], deck2 two: [Int]) -> Int {
			var oneCopy = one; var twoCopy = two; game += 1
			var currentGameHistory: Set<String> = [] //init
			var gamesEnd = false

			while !oneCopy.isEmpty && !twoCopy.isEmpty {
//				print("/n-----------Game \(game)----------")
//				print("Player 1's deck: ", oneCopy)
//				print("Player 2's deck: ", twoCopy)

				// check history!
				let historyHash = (oneCopy.map {String($0)}.joined(separator: ".") + "-"
									+ twoCopy.map {String($0)}.joined(separator: "."))
				if !currentGameHistory.insert(historyHash).inserted {
					//print("Cards in history! this game won by player one!")
					gamesEnd = true; break
				} else {
					//print("cards inserted in history")
				}

				let topOne = oneCopy.remove(at: 0); let topTwo = twoCopy.remove(at: 0)

				// check if recursion
				if topOne <= oneCopy.count && topTwo <= twoCopy.count {
					//print("Recursive Combat")
					let gameResult = playGame(deck1: Array(oneCopy.prefix(topOne)), deck2: Array(twoCopy.prefix(topTwo)))

					if gameResult == 1 {
						oneCopy.append(contentsOf: [topOne, topTwo])
					} else {
						twoCopy.append(contentsOf: [topTwo, topOne])
					}
					continue
				}

				// if no recursion play the game
				if topOne > topTwo {
					oneCopy.append(contentsOf: [topOne, topTwo])
				} else {
					twoCopy.append(contentsOf: [topTwo, topOne])
				}
			}
			//print("...anyway, back to previous game ")
			game -= 1
			if twoCopy.isEmpty || gamesEnd {
				winningDeck = oneCopy
				return 1
			} else {
				winningDeck = twoCopy
				return 2
			}
		}

		let result = playGame(deck1: one, deck2: two)
		range = Range(1...winningDeck.count).reversed()
		let score = zip(range, winningDeck).reduce(0) { $0 + $1.0 * $1.1 }

		print("Part two : winner is player: \(result) with score: ",score)
	}

}


// Run the parser.
Day22.main()


