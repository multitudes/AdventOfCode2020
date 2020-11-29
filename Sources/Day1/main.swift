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
Day1.main()

