// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode2020",
    dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser.git", from: "0.3.0"),
		.package(url: "https://github.com/multitudes/AdventKit.git", from: "0.5.3"),
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
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.target(
			name: "Day4",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.target(
			name: "Day5",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.target(
			name: "Day6",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.target(
			name: "Day7",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.target(
			name: "Day8",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.target(
			name: "Day9",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.target(
			name: "Day10",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.target(
			name: "Day11",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.target(
			name: "Day12",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.target(
			name: "Day13",
			dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "AdventKit", package: "AdventKit")],
			exclude: ["README.md"],
			resources: [.process("Resources")]
		),
		.testTarget(
			name: "Day2Tests",
			dependencies: ["AdventOfCode2020"]),
    ]
)
