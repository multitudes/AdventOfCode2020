import Foundation

let task = Process()
task.launchPath = "/usr/bin/swift"
task.arguments = ["run", "Day1"]
task.launch()
task.waitUntilExit()
