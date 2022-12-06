// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "ClosureSupport",
  platforms: [
    .iOS("16.0"),
    .macOS("13.0")
  ],
  products: [
    .library(
      name: "ClosureSupport",
      targets: ["ClosureSupport"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "ClosureSupport",
      dependencies: []),
    .testTarget(
      name: "ClosureSupportTests",
      dependencies: ["ClosureSupport"]),
  ]
)
