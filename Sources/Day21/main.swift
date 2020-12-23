import ArgumentParser
import Foundation
import AdventKit


// Define our parser.
struct Day21: ParsableCommand {
	//Declare optional argument. Drag the input file to terminal!
	@Option(name: [.short, .customLong("inputFile")], help: "Specify the path to the input file.")
	var inputFile : String = ""
	
	func run() throws {
		var input: [(ingredients: Set<String>, allergens: Set<String>)] = []
		if !inputFile.isEmpty {
			let url = URL(fileURLWithPath: inputFile)
			guard let inputFile = try? String(contentsOf: url).replacingOccurrences(of: "[,)]", with: "", options: .regularExpression).linesNotEmpty else {fatalError()}
			input = inputFile.map {$0.split(separator: " ")
				.map {String($0)}.split {$0 == "(contains"}}
				.map {return (ingredients: Set($0[0]),allergens: Set($0[1]))}
			input.sort {$0.allergens.count < $1.allergens.count}
		} else {
			print("Running Day21 Challenge with input from the website\n")
			guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else { fatalError()}
			//guard let url = Bundle.module.url(forResource: "Day17-example", withExtension: "txt") else { fatalError()}
			guard let inputFile = try? String(contentsOf: url).replacingOccurrences(of: "[,)]", with: "", options: .regularExpression).linesNotEmpty else {fatalError()}
			input = inputFile.map { $0.split(separator: " ")
				.map {String($0) }
				.split { $0 == "(contains"}}
				.map { return (ingredients: Set($0[0]),allergens: Set($0[1]))}
				input.sort {$0.allergens.count < $1.allergens.count}
		}
		print(input)



		//print(input.description)
		var myCanonicalDangerousIngredients: [(ingredient: String, allergen: String)] = []

		func removeEverywhere(ingredientFound: String, allergen: String) {
			// Part 2! add allergen to the list
			myCanonicalDangerousIngredients.append((ingredient: ingredientFound, allergen: allergen))
			for j in 0..<input.count {
				// when match found - 2 cases - both allergen and ingredient to be removed or
				if input[j].ingredients.contains(ingredientFound)
					&& input[j].allergens.contains(allergen) {
					print("removing input[\(j)]", ingredientFound, allergen)
					let _ = input[j].ingredients.remove(ingredientFound)!
					let _ = input[j].allergens.remove(allergen)!
					print("removed" )
					// or allergen is not listed so I remove only the ingredient
				} else if input[j].ingredients.contains(ingredientFound) {
					print("removing input[\(j)]", ingredientFound)
					let _ = input[j].ingredients.remove(ingredientFound)!
				}
			}
		}

		// my elements are sorted for max probability to get a single allergen in element
		var k = -1
		while !input.allSatisfy({ $0.allergens.isEmpty })   {
			// looping until all ingredients corresponding to our allergens are found
			k = k < input.count - 1 ? k + 1 : 0
			let currentElement = input[k]
			// I am looking for that element which has one allergen only
			if currentElement.allergens.isEmpty { continue }
			if currentElement.allergens.count > 1 { continue }
			// this one is already a match!
			if currentElement.ingredients.count == 1 && currentElement.allergens.count == 1 {
				print("1-1 match = remove everywhere ")
				removeEverywhere(ingredientFound: currentElement.ingredients.first!, allergen: currentElement.allergens.first!)
				k = -1 // restart because some elements before might have gotten freed up
				continue
			}
			// element with one allergen and many ingredients. need to check intersections! loop from the next element to end and look for an intersection. Then take the results of that intersection and intersect with the ingredients of the next element matching the allergen and hope to get the 1-1 match
			if currentElement.allergens.count == 1 {
				var mainIntersecting: Set<String> = currentElement.ingredients // init
				for i in 0..<input.count where i != k {
					//look for an intersection and if found remove the ingredient and element
					let currentAllergen = currentElement.allergens.first!
					print("looking for allergen ", currentAllergen)
					let elementToCheck = input[i]
					if elementToCheck.allergens.contains(currentAllergen)  {
						print("this contains : \(currentAllergen) ")
						mainIntersecting = elementToCheck.ingredients.intersection(mainIntersecting)
						print("ingredientsIntersecting ", mainIntersecting)
					}
					// this is a case of 1-1 match ingredients and allergen!
					if mainIntersecting.count == 1 {
						print("mainIntersecting.count == 1  ---------------------------------")
						removeEverywhere(ingredientFound: mainIntersecting.first!, allergen: currentElement.allergens.first!)
						break
					}
				}
			}
		}
		// count the ingredients left!
		let solutionPartOne = input.reduce(0) { $0 + $1.ingredients.count}

		print("Solution part one : ", solutionPartOne)

		//get the list of my Canonical Dangerous Ingredients)
		let myCanonicalDangerousIngredientsList = myCanonicalDangerousIngredients.sorted {$0.allergen < $1.allergen}
			.reduce("") {$0 + "," + $1.ingredient}.dropFirst() // drop first letter because that would be a comma! ;)

		print("Solution part two : ", myCanonicalDangerousIngredientsList)
	}
}

// Run the parser.
Day21.main()

extension String {
	var linesNotEmpty: [String] {
		components(separatedBy: .newlines).filter {$0 != "" }
	}
}
