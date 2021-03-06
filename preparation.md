# Preparation of the environment in Xcode

Last year I did the challenges in the Xcode Swift playgrounds.
I did encounter some problems though. Playgrounds are much slower in executing the code on their main page, because they are doing quite a few checks in the background and while it is fun to use them for try out some code, they do not offer the true Swift speed.
This year I wanna try something different with the Swift package manager. This allows me to have an executable package and to pack all my files in it.
Also I could eventually make a library with the most used functions and import it separately.  
Sounds like something new and exciting for me, so I can learn more about packages as well!  

The way to do it is to create a new directory, call it like `AdventOfCode2020` and `cd` to it:  
```bash
cd /Volumes/iOS/AdventOfCode2020
```
Next you need to init the package:  

```bash
swift package init --type executable
```

This will create the necessary files, your folder structure will look like this:  

```
➜ tree
.
├── Package.swift
├── README.md
├── Sources
│   └── AdventOfCode2020
│       └── main.swift
└── Tests
    ├── AdventOfCode2020Tests
    │   ├── AdventOfCode2020Tests.swift
    │   └── XCTestManifests.swift
    └── LinuxMain.swift

4 directories, 6 files
```
Now build:

```bash
swift build
```
And run!

```bash
swift run AdventOfCode2020
// Hello, world!
```
This is the output of our executable because in our package we have a `main.swift` file. This file is special, it is the only one file that is called automatically by the system and executed first. Also it allows to put commands on the top level!
this are the contents of the `main.swift` file, a famous one liner: `print("Hello, world!")`

When I do `run AdventOfCode2020` I execute the main swift file in the `AdventOfCode2020` folder (under sources).

And I can do testing as well with `swift tests`


### Creating folders for each day
It will be nice to just be free to execute the code for any day passing the arguments so I will create a `Day1` folder containing another main.swift file to be executed like:

`swift run Day1`

My tree will look like this now:  

```bash
➜ tree
.
├── LICENSE
├── Package.swift
├── README.md
├── Sources
│   ├── AdventOfCode2020
│   │   └── main.swift
│   └── Day1
│       └── main.swift
└── Tests
    ├── AdventOfCode2020Tests
    │   ├── AdventOfCode2020Tests.swift
    │   └── XCTestManifests.swift
    ├── Day1Tests
    │   ├── Day1Tests.swift
    │   └── XCTestManifests.swift
    └── LinuxMain.swift

6 directories, 10 files
```

And to allow this I will need to modify the Package manifest file:

```swift
// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2020",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AdventOfCode2020",
            dependencies: []),
        .testTarget(
            name: "AdventOfCode2020Tests",
            dependencies: ["AdventOfCode2020"]),
	.target(
		name: "Day1",
		dependencies: []),
	.testTarget(
		name: "Day1Tests",
		dependencies: ["AdventOfCode2020"]),
    ]
)


```
If I click on the package file, it opens in Xcode and there I can just easily select which target I want to run, as you see in the top left corner.

!["Run a target in XCode"](/images/aoc1.png)

My script can receive arguments as input. 

### Parse Input Arguments

```swift
import ArgumentParser

// Define our parser.
struct Day1: ParsableCommand {
  // Declare expected launch argument(s).
  @Option(help: "Specify an Integer.")
  var input: Int

  func run() throws {
	print("Running Day1 Challenge with input \(input)")
  }
}

// Run the parser.
Hello.main()
```

I need to import the Argument Parser package and add it as a dependency

Now I run the target I get correctly a prompt, saying that my usage is not correct and I am expecting an Int! 

!["Run a target in XCode"](/images/aoc2.png)

I will add this clicking on my target and add it in `arguments`

!["Run a target in XCode"](/images/aoc3.png)  
!["Run a target in XCode"](/images/aoc4.png)  


So the environment is now set up 😀

## Sources

Swift Package Manager: [https://docs.swift.org/package-manager/](https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html)  
Five stars blog : [fivestars.blog](https://fivestars.blog/code/ultimate-guide-swift-executables.html)  
Argument Parser: [https://github.com/apple/swift-argument-parser/](https://github.com/apple/swift-argument-parser/blob/main/Documentation/01%20Getting%20Started.md)
