
[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg?style=plastic)](https://opensource.org/licenses/MIT)
[![Swift](https://img.shields.io/badge/Swift-5.3-red.svg?style=plastic&logo=Swift&logoColor=white)](https://opensource.org/licenses/MIT)
[![twitter](https://img.shields.io/badge/twitter-wrmultitudes-blue.svg?style=plastic&logo=twitter&logoColor=white)](https://twitter.com/wrmultitudes)
[![hashnode](https://img.shields.io/badge/hashnode-laurentbrusa-blue?style=plastic&logo=hashnode&logoColor=white)](https://laurentbrusa.hashnode.dev)

# Advent Of Code 2020 in Swift✨🚀   
 
## What is Advent of Code?
[Advent of Code](http://adventofcode.com) is an online event created by [Eric Wastl](https://twitter.com/ericwastl). Each year an advent calendar of small programming puzzles is unlocked once a day, they can be solved in any programming language you like. 


## Preparing the environment

[Last year](https://github.com/multitudes/Advent-of-Code-2019/blob/master/README.md) I did the challenges in the Xcode Swift playgrounds.  
This year I wanna try something different with the [Swift package manager](https://swift.org/getting-started/#using-the-package-manager).
You can read more in my blog post [here](https://laurentbrusa.hashnode.dev/preparing-xcode-for-the-advent-of-code-2020-in-swift)

## Advent of Code 2020 Story

After saving Christmas five years in a row, you've decided to take a vacation at a nice resort on a tropical island. Surely, Christmas will go on without you.  

The tropical island has its own currency and is entirely cash-only. The gold coins used there have a little picture of a starfish; the locals just call them stars. None of the currency exchanges seem to have heard of them, but somehow, you'll need to find fifty of these coins by the time you arrive so you can pay the deposit on your room.  

To save your vacation, you need to get all fifty stars by December 25th.  

Collect stars by solving puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!  

## Progress
| Day  | Part One | Part Two |
|---|:---:|:---:|
| ✅ [Day 1: Report Repair](https://adventofcode.com/2020/day/1)|⭐️|⭐️|
| ✅ [Day 2: Password Philosophy](https://adventofcode.com/2020/day/2)|⭐️|⭐️|

## Day 1 
Most of the time on day one has been spent on the Swift Package Manager. Of course the code I used to write in the Playgrounds to load the input file doesnt work in the SPM Xcode environment.   
In the Playgrounds I could put my input.txt file in the Resources folder and it would appear to me under `Bundle.main.url(forResouce: withExtension:)`
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

https://developer.apple.com/documentation/swift_packages/bundling_resources_with_a_swift_package  

Lesson learned!


## Day 2
I had to refresh my regexes! For troubleshooting the pattern I used Lea Verou Regex playground:  
https://projects.verou.me/regexplained/  
Regex in Swift is pretty hard when you try to capture groups. I had to look in Stackoverflow to keep my sanity.  
The code for this is again probaly 20 times longer than the Python equivalent. Swift really should get his regexes together! ;)
