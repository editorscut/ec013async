// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "DelegateSupport",
  platforms: [
    .iOS("16.0"),
    .macOS("13.0")
  ],
  products: [
    .library(
      name: "DelegateSupport",
      targets: ["DelegateSupport"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "DelegateSupport",
      dependencies: []),
    .testTarget(
      name: "DelegateSupportTests",
      dependencies: ["DelegateSupport"]),
  ]
)
