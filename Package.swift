// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2020",
    dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.3.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AdventOfCode2020",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .testTarget(
            name: "AdventOfCode2020Tests",
            dependencies: ["AdventOfCode2020"]),
		.target(
			name: "Day1",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]),
		.testTarget(
			name: "Day1Tests",
			dependencies: ["AdventOfCode2020"]),
    ]
)
