import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day10: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""
	
	func run() throws {
		var input: [String] = []
		if !inputFile.isEmpty {
			let url = URL(fileURLWithPath: inputFile)
		} else {
			print("Running Day10 Challenge with input from the website\n")
			guard let fileURL = Bundle.module.url(forResource: "input", withExtension: "txt") else {
				fatalError("Input file not found")
			}
			guard let inputFile: [String] = try? String(contentsOf: fileURL).components(separatedBy: .whitespacesAndNewlines) else {fatalError()}
			input = inputFile
		}

		enum SeatState: Character {
			case occupied = "#", empty = "L", floor = ".", padding = " "
			static func toggle(_ seatState: SeatState) -> SeatState {
				if seatState == .occupied {return .empty }
				if seatState == .empty {return .occupied }
				return seatState
			}
		}


		// create seatmap with padding
		var seatMap = input.compactMap { string -> [Character]? in
			if !string.isEmpty {
				let newString = " " + string + " "
				return Array(newString)
			}
			return nil
		}
		let inputColumns = seatMap[0].count
		let padding = Array(repeating: Character(" "), count: inputColumns)
		seatMap.insert(padding, at: 0)
		seatMap.append(padding)
		print(seatMap)

		func checkAdjacentsAreOccupied(row i: Int, col k: Int) -> Int {
			var adjacents = 0
			if seatMap[i-1][k-1] == SeatState.occupied.rawValue { adjacents += 1 }
			if seatMap[i-1][k] == SeatState.occupied.rawValue {adjacents += 1 }
			if seatMap[i-1][k+1] == SeatState.occupied.rawValue {adjacents += 1 }
			if seatMap[i][k-1] == SeatState.occupied.rawValue {adjacents += 1 }
			if seatMap[i][k+1] == SeatState.occupied.rawValue {adjacents += 1 }
			if seatMap[i+1][k-1] == SeatState.occupied.rawValue {adjacents += 1 }
			if seatMap[i+1][k] == SeatState.occupied.rawValue {adjacents += 1 }
			if seatMap[i+1][k+1] == SeatState.occupied.rawValue {adjacents += 1 }
			return adjacents
		}
		let maxColumns = seatMap[0].count
		let maxRows = seatMap.count
		//start

		func oneSeatingShuffle(_ seatMap: [[Character]], with currentSeat: SeatState ) ->  (nextMap: [[Character]], isSameState: Bool, occupiedSeats: Int) {
			var nextSeatMap = seatMap
			var occupiedSeats = 0
			for i in 1..<maxRows - 1 {
				print(seatMap[i])
				for k in 1..<maxColumns - 1 {
					if seatMap[i][k] == SeatState.occupied.rawValue {occupiedSeats += 1 }
					if ". ".contains(seatMap[i][k]) {continue}
					let adjacents = checkAdjacentsAreOccupied(row: i, col: k)
					if currentSeat == SeatState.empty {
						if adjacents == 0 {	nextSeatMap[i][k] = SeatState.occupied.rawValue }
					} else if currentSeat == SeatState.occupied {
						if adjacents >= 4  { nextSeatMap[i][k] = SeatState.empty.rawValue }
					}
				}
			}
			for map in nextSeatMap {
				print(map.map { String($0)}.joined())}
			print("same than last? ",seatMap == nextSeatMap, "occupiedSeats", occupiedSeats)
			return (nextMap: nextSeatMap, isSameState: seatMap == nextSeatMap, occupiedSeats: occupiedSeats)
		}
		var isSame = false
		var seatState = SeatState(rawValue: "L")!
		var occupiedSeats = 0
		while isSame == false {

			(seatMap, isSame, occupiedSeats) = oneSeatingShuffle(seatMap, with: seatState)
			seatState = SeatState.toggle(seatState)

		}

		print("solution: ", occupiedSeats)
	}
}

// Run the parser.
Day10.main()


