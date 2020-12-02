// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2020",
    dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.3.0"),
		.package(url: "https://github.com/multitudes/AdventKit.git", from: "0.0.0"),
    ],
    targets: [
        .target(
            name: "AdventOfCode2020",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]),
        .testTarget(
            name: "AdventOfCode2020Tests",
            dependencies: ["AdventOfCode2020"]),
		.target(
			name: "Day1",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
						   .product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.testTarget(
			name: "Day1Tests",
			dependencies: ["AdventOfCode2020"]),
		.target(
			name: "Day2",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
							.product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.target(
			name: "Day3",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.testTarget(
			name: "Day2Tests",
			dependencies: ["AdventOfCode2020"]),
    ]
)
