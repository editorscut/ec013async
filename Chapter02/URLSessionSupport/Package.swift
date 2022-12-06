// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "URLSessionSupport",
  platforms: [
    .iOS("16.0"),
    .macOS("13.0")],
  products: [
    .library(
      name: "URLSessionSupport",
      targets: ["URLSessionSupport"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "URLSessionSupport",
      dependencies: []),
    .testTarget(
      name: "URLSessionSupportTests",
      dependencies: ["URLSessionSupport"]),
  ]
)
