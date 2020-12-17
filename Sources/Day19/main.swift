import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day17: ParsableCommand {
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
			print("Running Day17 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else { fatalError()}
			//guard let url = Bundle.module.url(forResource: "Day17-example", withExtension: "txt") else { fatalError()}

			guard let inputFile = try? String(contentsOf: url) else {fatalError()}
			input = inputFile
		}
		print(input)
		let partOne = false
		if partOne {
			struct Cube: Equatable, Hashable {
				let x,y,z: Int
			}

			struct PocketDimension {
				var actives : Set<Cube> = []
				var inactives: Set<Cube> = []
				var nextActives : Set<Cube> = []
				var nextInactives: Set<Cube> = []
				static var cycles = 0
				init(input: String) {
					let bootSector = input.lines
					for (yIndex, y) in bootSector.enumerated() {
						print(y)
						for (xIndex,x)  in y.enumerated() {
							if x == "#" { actives.insert(Cube(x: xIndex, y: yIndex, z: 0))} else {
								inactives.insert(Cube(x: xIndex, y: yIndex, z: 0)); continue}
						}
					}
				}

				func printBootSector() {
					for z in -Self.cycles...Self.cycles {
						print("\nLayer \(z)")
						for y in -10...10 {
							for x in -10...10 {
								let cube = Cube(x: x, y: y, z: z)
								if actives.contains(cube) {print("#", terminator: "")} else {print(".",terminator: "")}
							}
							print("\n", terminator: "")
						}
					}
				}

				mutating func runCycle() {
					for cube in actives {
						var count = 0
						for z in -1...1 {
							for y in -1...1 {
								for x in -1...1 {
									//print("x y z ", x, y, z, "....................")
									// this is my current position so skip
									if x == 0 && y == 0 && z == 0 { continue }
									//create an imaginary cube as neighbour
									let cube = Cube(x: (cube.x + x), y: (cube.y + y), z: (cube.z + z))
									// if this position is not already active append inactive
									if actives.contains(cube) {
										count += 1
									} else {
										inactives.insert(cube)
									}
								}
							}
						}
						if 2...3 ~= count { nextActives.insert(cube) } else {
							nextInactives.insert(cube)
						}
					}

					for cube in inactives {
						var count = 0
						for z in -1...1 {
							for y in -1...1 {
								for x in -1...1 {
									//print("x y z ", x, y, z, "....................")
									// this is my current position so skip
									if x == 0 && y == 0 && z == 0 { continue }
									//create an imaginary cube as neighbour
									let cube = Cube(x: (cube.x + x), y: (cube.y + y), z: (cube.z + z))
									// if this position is not already active append inactive
									if actives.contains(cube) {
										count += 1
									} else {
										nextInactives.insert(cube)
									}
								}
							}
						}
						if count == 3 {nextActives.insert(cube)} else {nextInactives.insert(cube)}
					}
					actives = nextActives
					nextActives = []
					inactives = nextInactives
					nextInactives = []
					Self.cycles += 1
					printBootSector()
				}

			}

			var boot = PocketDimension(input: input)
			print(boot.printBootSector())
			boot.runCycle()
			boot.runCycle()
			boot.runCycle()
			boot.runCycle()
			boot.runCycle()
			boot.runCycle()
			print("Solution Part One : ",boot.actives.count)

		} else {
			struct Cube: Equatable, Hashable {let x,y,z,w: Int}

			struct PocketDimension {
				var actives : Set<Cube> = []
				var inactives: Set<Cube> = []
				var nextActives : Set<Cube> = []
				var nextInactives: Set<Cube> = []
				static var cycles = 0

				init(input: String) {
					let bootSector = input.lines
					for (yIndex, y) in bootSector.enumerated() {
						for (xIndex,x)  in y.enumerated() {
							if x == "#" { actives.insert(Cube(x: xIndex, y: yIndex, z: 0, w: 0))} else {
								inactives.insert(Cube(x: xIndex, y: yIndex, z: 0, w: 0)); continue}
						}
					}
				}

				func printBootSector() {
					for w in -Self.cycles...Self.cycles {
						for z in -Self.cycles...Self.cycles {
							print("\nLayer \(z), \(w)")
							for y in -10...10 {
								for x in -10...10 {
									let cube = Cube(x: x, y: y, z: z, w: w)
									if actives.contains(cube) {print("#", terminator: "")} else {print(".",terminator: "")}
								}
								print("\n", terminator: "")
							}
						}
					}
				}

				mutating func runCycle() {
					for cube in actives {
						var count = 0
						for w in -1...1 {
							for z in -1...1 {
								for y in -1...1 {
									for x in -1...1 {
										// this is my current position so skip
										if x == 0 && y == 0 && z == 0 && w == 0 { continue }
										//create an imaginary cube as neighbour
										let neighbour = Cube(x: (cube.x + x), y: (cube.y + y), z: (cube.z + z), w: (cube.w + w))
										// if this position is active count, if not active insert in inactives
										if actives.contains(neighbour) {
											count += 1
											continue
										} else {
											inactives.insert(neighbour)
										}
									}
								}
							}
						}
						if 2...3 ~= count { nextActives.insert(cube) } else {
							nextInactives.insert(cube)
						}
					}

					for cube in inactives {
						var count = 0
						for w in -1...1 {
							for z in -1...1 {
								for y in -1...1 {
									for x in -1...1 {
											// this is my current position so skip
										if x == 0 && y == 0 && z == 0 && w == 0{ continue }
										//create an imaginary cube as neighbour
										let neighbour = Cube(x: (cube.x + x), y: (cube.y + y), z: (cube.z + z), w: (cube.w + w))
										// if this position is not active insert in next inactive
										if actives.contains(neighbour) {
											count += 1
										} else {
											nextInactives.insert(neighbour)
										}
									}
								}
							}
						}
						if count == 3 {nextActives.insert(cube)} else {nextInactives.insert(cube)}
					}
					actives = nextActives
					nextActives = []
					inactives = nextInactives
					nextInactives = []
					Self.cycles += 1
					print("---------------- cycle \(Self.cycles) -------------")
					//printBootSector()
				}

			}

			var boot = PocketDimension(input: input)
			print(boot.printBootSector())
			boot.runCycle()
			boot.runCycle()
			boot.runCycle()
			boot.runCycle()
			boot.runCycle()
			boot.runCycle()
			print("Solution Part Two : ",boot.actives.count)
		}
	}

}


// Run the parser.
Day17.main()


