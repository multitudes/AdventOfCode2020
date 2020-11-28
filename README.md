# AdventOfCode2020
 Advent Of Code 2020 in Swift

## Preparation of the environment

Last year I did the challenges in the Xcode Swift playgrounds. I did encounter some problems though. Playgrounds are much slower in executing the code on their main page, they are doing quite a few checks in the background and it is fun to use them for try out some code, however they do not offer the true Swift speed of execution.
This year I wanna try something different with the Swift package manager. This allows me to have an executable package and I can pack all my files in it. Also I could eventually make a library with the most used function and import it separately. Sounds like something new and exciting for me, so I can learn more about packages as well

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


## Sources

Swift Package Manager
Five star blog
