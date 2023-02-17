enum Tracker {}

extension Tracker {
  @TaskLocal static var searchTerm = "(missing search term)"
  @TaskLocal static var appName = "(no app name available)"
  @TaskLocal static var totalImages = 0
}
