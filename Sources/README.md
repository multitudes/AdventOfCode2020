
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
| ✅ [Day 4: Passport Processing](https://adventofcode.com/2020/day/4)|⭐️|🙃|


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
