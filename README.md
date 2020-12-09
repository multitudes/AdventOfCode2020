
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg?style=plastic)](https://opensource.org/licenses/MIT)
[![Swift](https://img.shields.io/badge/Swift-5.3-red.svg?style=plastic&logo=Swift&logoColor=white)](https://opensource.org/licenses/MIT)
[![twitter](https://img.shields.io/badge/twitter-wrmultitudes-blue.svg?style=plastic&logo=twitter&logoColor=white)](https://twitter.com/wrmultitudes)
[![hashnode](https://img.shields.io/badge/hashnode-laurentbrusa-blue?style=plastic&logo=hashnode&logoColor=white)](https://laurentbrusa.hashnode.dev)

# Advent Of Code 2020 in Swift ✨🏝  
 
## What is Advent of Code?
[Advent of Code](http://adventofcode.com) is an online event created by [Eric Wastl](https://twitter.com/ericwastl). Each year an advent calendar of small programming puzzles is unlocked once a day, they can be solved in any programming language you like. 

## Progress
| Day  | Part One | Part Two |
|---|:---:|:---:|
| ✅ [Day 1: Report Repair](https://adventofcode.com/2020/day/1)|⭐️|⭐️|
| ✅ [Day 2: Password Philosophy](https://adventofcode.com/2020/day/2)|⭐️|⭐️|
| ✅ [Day 3: Toboggan Trajectory](https://adventofcode.com/2020/day/3)|⭐️|⭐️|
| ✅ [Day 4: Passport Processing](https://adventofcode.com/2020/day/4)|⭐️|⭐️|
| ✅ [Day 5: Binary Boarding](https://adventofcode.com/2020/day/5)|⭐️|⭐️|
| ✅ [Day 6: Custom Customs](https://adventofcode.com/2020/day/6)|⭐️|⭐️|
| ✅ [Day 7: Handy Haversacks](https://adventofcode.com/2020/day/7)|⭐️|⭐️|
| ✅ [Day 8: Handheld Halting](https://adventofcode.com/2020/day/8)|⭐️|⭐️|
| ✅ [Day 9: Encoding Error](https://adventofcode.com/2020/day/9)|⭐️|⭐️|
| ✅ [Day 10: ??????????](https://adventofcode.com/2020/day/10)|||

## Preparing the environment

[Last year](https://github.com/multitudes/Advent-of-Code-2019/blob/master/README.md) I did the challenges in the Xcode Swift playgrounds.  
This year I wanna try something different with the [Swift package manager](https://swift.org/getting-started/#using-the-package-manager).
You can read more in my blog post [here](https://laurentbrusa.hashnode.dev/preparing-xcode-for-the-advent-of-code-2020-in-swift)  
I created a package with some common used functions and structs/classes, the `AdventKit`:  
https://github.com/multitudes/AdventKit/blob/main/README.md

## Advent of Code 2020 Story

After saving Christmas five years in a row, you've decided to take a vacation at a nice resort on a tropical island. Surely, Christmas will go on without you.  

The tropical island has its own currency and is entirely cash-only. The gold coins used there have a little picture of a starfish; the locals just call them stars. None of the currency exchanges seem to have heard of them, but somehow, you'll need to find fifty of these coins by the time you arrive so you can pay the deposit on your room.  

To save your vacation, you need to get all fifty stars by December 25th.  

Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!  

# A sort of diary

## Day 1 
Most of the time on day one has been spent on the Swift Package Manager. Of course the code I used to write in the Playgrounds to load the input file doesnt work in the SPM Xcode environment.   
In the Playgrounds I could put my input.txt file in the Resources folder and it would appear to me under `Bundle.main.url(forResource: withExtension:)`
So in code I would load the input like this:  
```swift
var input: [Int] = []
do {
	guard let fileUrl = Bundle.main.url(forResource: "input", withExtension: "txt") else {
		fatalError("error input not found")
	}
	input = try String(contentsOf: fileUrl).split(separator: "\n").compactMap {Int($0)}.sorted()
	} catch {
	print(error.localizedDescription)
}
```

Compare this to this python code 🙃 :   
```python
with open('input.txt', 'r') as file:
    data = {int(number) for number in file}
```   

Anyway the SPM would not find my `input.txt` file! After trying everything including looking in `FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)` and trying to put the input file in different levels of folders, I found out the answer in the Apple docs:  
```swift
var input: [Int] = []
	do {
		let fileUrl = Bundle.module.url(forResource: "input", withExtension: "txt")!
		input =  try String(contentsOf: fileUrl).split(separator: "\n").compactMap {Int($0)}
	} catch {
		print(error.localizedDescription)
	}
```
the solution is here in `module`:  
`Bundle.module.url(forResource: "input", withExtension: "txt")!`, the module static keyword is created by swift when I use the package and when I declare the dependency in the Package manager!  
Do not forget to update it like this, where Resources is my resources folder containing the input file...
```swift
.target(
	name: "Day1",
	dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")],
	exclude: ["README.md"],
	resources: [.process("Resources")]
	),
```

https://developer.apple.com/documentation/swift_packages/bundling_resources_with_a_swift_package  

Lesson learned!


## Day 2
I had to refresh my regexes! For troubleshooting the pattern I used Lea Verou Regex playground:  
https://projects.verou.me/regexplained/  
Regex in Swift is pretty hard when you try to capture groups. I had to look in Stackoverflow to keep my sanity.  
The code for this is again probaly 20 times longer than the Python equivalent. Swift really should get his regexes together! ;)
I still managed to create an extension of String spitting out an array of the regex groups
```swift
extension String {

	func getCapturedGroupsFrom(regexPattern: String)-> [String]? {
		let text = self
		let regex = try? NSRegularExpression(pattern: regexPattern)

		let match = regex?.firstMatch(in: text, range: NSRange(text.startIndex..., in: text))

		if let match = match {
			return (0..<match.numberOfRanges).compactMap {
				$0 > 0 ? String(text[Range(match.range(at: $0), in: text)!]) : nil
			}
		}
		return nil
	}
}

"6-10 h: pqlfbhcnglgvhdgddn".getCapturedGroupsFrom(regexPattern: "(\\d+)-(\\d+) ([a-z]). ([a-z]+)")
// returns ["6", "10", "h", "pqlfbhcnglgvhdgddn"] or nil if the pattern has no match!
```
I feel slowly better now!

Another thing I liked about today is that I finally got to use this Swift nice boolean operator: `~=`
It means the range contains the element:
```swift
public var isValid: Bool {
	self.frequency ~= self.string.reduce(0) {
		$1 == self.char ? $0 + 1 : $0
	}
}
```
Where `frequency` is a CloseRange like `1...3`, `~=` means contains and the right part is the count of the character in the string. So if the closed range contains the count of the character then the password is valid...

## Day 3
What I learned today is that you cannot have an extension for tuples! I wanted to overload my TupleType to make addition possible, but turns out that they are a compound type. I can only extend data types like Collections etc.  Makes sense now.
https://docs.swift.org/swift-book/ReferenceManual/Types.html#grammar_tuple-type

It would have been nice to declare two tuples a and b and get a + b with the sum of a.x + b.x and a.y and b.y. 
Since they are conpound types and variadic, this approach is not possible. Just making a function for this is the way to go:
```swift
func jump(from position:(x: Int, y: Int), with offset: (x: Int, y: Int)) -> (Int,Int) {
	return (x: position.x + offset.x, y: position.y + offset.y)
}
```
I took my input file and split in an array of `String`. A row is then converted in an array of `Character`.  


## Day 4

Today the second part was quite tedious to be honest. Still fun though!  
The input file had a list of passport data separated by empty lines. 

How do you do that in Swift? 
I created a String extension called `lines`
```swift
public extension String {
	var lines: [String] {
		components(separatedBy: .newlines)
	}
}
```
This result in an array of string with the occasional `""` blank, need to split at `""` (note this variant of split is special) and returns a substring which needs to be converted to an array with `compactMap`. So I would get an array of arrays!! 🙃 This is why I need to join at the end every subarray. Phew.  
and then having an array of lines I got the array of passport data with:
```swift
let inputString = try String(contentsOf: url)
input = inputString.lines.split { $0 == "" }.compactMap {Array($0)}.map { $0.joined(separator: " ")}
```
Result is like an array of `"eyr:1972 cid:100 hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926"` 

I then created a `Passport` struct which has an initializer taking my input string which create a dictionary out of it using a regex:
```swift
init(passportData: String) {
	let fieldsDataArray = passportData.components(separatedBy: .whitespaces)
	fieldsDataArray.forEach { if let field =  $0.getCapturedGroupsFrom(regexPattern: "(\\w+):([#\\w]+)") { fields[field[0]] = field[1] }
	}
}
```
The rest is creating computed variables in the struct so I can iterated on the data and filter the valid passports:

```swift
let solution1 = input.filter {Passport(passportData: $0).areValidNorthPoleCredentials}.count
let solution2 = input.filter {Passport(passportData: $0).validatedCredentials }.count
```

## Day 5

Today was a relaxing boarding day, even if our chqaracter dropped his boarding pass after all the work we did to validate his credentials!
(You can see the whole boarding video [here](https://www.youtube.com/watch?v=oAHbLRjF0vo))
<p align="center">
  <img src="/images/boarding2.gif" width="600"  title="boarding"></img>
</p>

The interesting bit has been, how to convert a string to a binary and then an integer?  
At the beginning I used a BoardingPass struct with row and column, getting the ID with row* 8 + column...
But the elves tricked me! I just realised much later that when having a ten digit binary number, the first 7 digits multiplied by 8 plus the last 3 digits is the same number! 🙃
This is my code refactored for brevity but still safe without crazy force unwrappings!
```swift

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt")
	else {fatalError("Input file not found")}
guard let inputString = try? String(contentsOf: url)
	else { fatalError("Input file not found") }
var input = inputString.components(separatedBy: .newlines)
input.removeAll { $0.isEmpty }

func getSeatID(_ inputString: String) -> Int? {
	if let seatID = Int(Array(inputString).reduce(""){ result, c in
		result + ("FL".contains(c) ? "0" : "1")},radix:  2) {
			return seatID
	} else { print("\nError, invalid seatID received!"); return nil}
}
let seats = input.compactMap {getSeatID($0)}

let maxSeatNumber = seats.reduce(0) {max($0, $1)}
print("solution part 1 is \(maxSeatNumber)")
// 980

let minSeatNumber = seats.reduce(Int.max) {min($0, $1)}
let contiguousSet = Set(minSeatNumber...maxSeatNumber)
if let solution2 = contiguousSet.subtracting(Set(seats)).first  {
	print("solution part 2 is \(solution2)")
}  else {
	print("No seats available for you!! ")
}
//607
```
## Day 6

```swift
guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {fatalError()}
//guard let url = Bundle.main.url(forResource: "Day6-example", withExtension: "txt") else {fatalError()}
guard let input = try? String(contentsOf: url) else {fatalError()}

let groups = input.split(omittingEmptySubsequences: false, whereSeparator: \.isWhitespace)
// ["abc", "", "a", "b", "c", "", "ab", "ac", "", "a", "a", "a", "a", "", "b"]
let forms = groups.split(whereSeparator: { $0.isEmpty}).map {Array($0).map {Array($0)} }
// [ArraySlice(["abc"]), ArraySlice(["a", "b", "c"]), ArraySlice(["ab", "ac"]) ...
var sets = forms.map {Set($0) }
//[Set([["a", "b", "c"]]), Set([["a"], ["c"], ["b"]]), Set([["a", "c"], ["a", "b"]]), Set([["a"]]), Set([["b"]])]

let solution = sets.map {Set($0.reduce([], +)).count}.reduce(0, +)
//6590
```
First Draft! :   
This is part 2 before refactoring. I had a hard time at first understanding the types of the results before using sets doing my intersections!
```swift
var solution2 = 0
for set in sets {
	print("set in sets ", set) //[["a", "b", "c"]]
	var myStartSubset = Set(set.first!)
	for subset in set {
		print("myStartSubset ",myStartSubset)
		print("subset ",subset)
		let intersection = myStartSubset.intersection(subset)
		print("intersection ",intersection)
		myStartSubset = intersection
	}
	print("intersection ", myStartSubset, "count ",myStartSubset.count)
	solution2 += myStartSubset.count
}
3288
```

Of course when I see the pattern looking like this:
```swift
extension Array {
	func reduce<T>(_ initial: T, combine: (T, Element) -> T) -> T {
		var result = initial
		for x in self {
			result = combine(result, x)
		}
		return result
	}
}
```
I can refactor the above code to use some functional programming!

```swift
let solution2 = sets.reduce(0) { sum, set in
	let intersection = set.reduce(Set(set.first ?? [])) { res,subSet in
		res.intersection(subSet) }
	return sum + intersection.count
}
solution2 //3288
```

## Day 7
The theme today has been recursion!
Regex in Swift is quite cumbersome to use. I had a Regex pattern which worked beautifully on the web in the Lea Verou playground but not in Swift. Lost quite a while understanding why.. I still do not know but I solved the challenge differently.
The best part is the data structure. I ws quite at loss at first. Then I realised a dictionary of an array of tuple would be perfect:  
`shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.` gets converted to a dic where the key is `shiny gold` and the value an array of two tuples like:  
`[(1,"dark olive"), (2, "vibrant plum")]`  
This worked very well, especially in the second part.

This is the code:
```swift
var rules = input.lines.compactMap {$0.trimmingCharacters(in: .punctuationCharacters)}
var rulesDict: [String: [(numberOfBags:Int, bagType: String)]] = [:]
rules.forEach {
	if let groups = $0.getTrimmedCapturedGroupsFrom(regexPattern:"([a-z ]+)bags? contain (.+)") {
		let key = groups[0]
		let contents = groups[1].split(separator: ",").map {String($0)}
		contents.forEach { content in
			if let data = content.getTrimmedCapturedGroupsFrom(regexPattern:"(\\d) (\\w+ \\w+) bags?") {
				let dataTuple: (numberOfBags:Int, bagType: String) = (numberOfBags: Int(data[0]) ?? 0, bagType: data[1])
				rulesDict[key, default: []] += [dataTuple]
			}
		}
	}
}

var cache = [String:Bool]()
func containsRecursively(bag: String, in dict: [String: [(numberOfBags: Int, bagType: String)]]) -> Bool {
	if bag == "shiny gold" {return true}
	if let result = cache[bag] {return result}
	let bags = dict[bag, default: []]
	for bag in bags {
		if containsRecursively(bag: bag.bagType, in: dict) == true {
			return true
		}
		cache[bag.bagType] = false
	}
	return false
}

let solution1 = rulesDict.keys.reduce(0) { count, key in
	if key != "shiny gold" && containsRecursively(bag: key, in: rulesDict) == true { return count + 1
	} else { return count }
}
// 161

var shinyCache = [String:Int]()
func countBagsInside(for bag: String, in dict: [String: [(numberOfBags: Int, bagType: String)]]) -> Int {
	if let cached = shinyCache[bag] {
		return cached }
	let contentsOfBag = dict[bag, default: []]
	if contentsOfBag.isEmpty { return 0 }
	let total = contentsOfBag.reduce(0) {subTotal, element in
		subTotal + element.numberOfBags + (element.numberOfBags * countBagsInside(for: element.bagType, in: dict))
	}
	shinyCache[bag] = total
	return total
}

let solution2 = countBagsInside(for: "shiny gold", in: rulesDict)
//30899

```
## Day 8

Relatively easy today. This is my solution. I probably did not need the regex or the enum!
```swift
enum Operation: String, CustomStringConvertible {
	case acc, jmp, nop
	init?(_ rawValue:String) {
		self.init(rawValue:rawValue)
	}
	var description : String { return self.rawValue }
}

guard let url = Bundle.main.url(forResource: "input", withExtension: "txt") else {fatalError()}
guard let input = try? String(contentsOf: url).lines else {fatalError()}
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

```
## Day 9
Thoughts about today? Well! On the Xcode playgrounds the code took one minute to run. On Xcode was almost instantaneous.
At first I looked for optimisations.  
I used the data type `Array<Int>.SubSequence` which is optimized and works by reference! It needs creful handling at times but the compiler will help you.
For instance, the method `prefix(_ :) ` on my array `[Int]` returns an `ArraySlice<Int>` which is also a `Array<Int>.SubSequence`.
```swift
var input = inputLines
let preamble = 25; var workingQueue = input.prefix(preamble)
var runningIndex = preamble; let count = input.count
while runningIndex < count {
	let next = input[runningIndex]
	if !checksums(queue: workingQueue, with: next).isValid {
		print("Solution part 1: ", next) //18272118
		print("Solution part 2: ", checkForRange(with: next) ?? 0) // 2186361
		break
	}
	workingQueue = workingQueue.dropFirst()
	workingQueue.append(next)
	runningIndex += 1
}

func checkForRange(with invalidNumber: Int) -> Int? {
	for i in 0..<count {
		var partialSum = 0; runningIndex = i
		var subSequence: Array<Int>.SubSequence = []
		while runningIndex < count - 1 {
			let currentNumber = input[runningIndex]
			runningIndex += 1; partialSum += currentNumber
			subSequence.append(currentNumber)
			if partialSum >  invalidNumber {break}
			if partialSum == invalidNumber {
				if subSequence.count == 1 {continue}
				return subSequence.sorted().first! + subSequence.sorted().last!
			}
		}
	}
	return nil
}

//check the workingQ is valid!
func checksums(queue: Array<Int>.SubSequence, with next: Int) -> (isValid:Bool, solution: Int? ) {
	let q = queue.sorted();	let lastIndex = q.count - 1
	var first:Int = 0; var last: Int = lastIndex
	if q[lastIndex] + q[lastIndex-1] < next {return (false, next)}
	while first < last {
		let sum = q[first] + q[last]
		switch sum  {
			case next : return (true, nil)
			case (..<next): first += 1;	continue
			default: last -= 1;	continue
		}
	}
	return (false, next)
}
```

