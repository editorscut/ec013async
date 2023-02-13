// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Package description for the shared modules.
*/
import PackageDescription

var globalSwiftSettings: [SwiftSetting] = []

var targets: [Target] = [
    .target(
        name: "BonjourDemoActorSystem",
        dependencies: [
                    .product(name: "NIO", package: "swift-nio"),
                    .product(name: "NIOHTTP1", package: "swift-nio"),
                    .product(name: "NIOWebSocket", package: "swift-nio"),
                    .product(name: "NIOTransportServices", package: "swift-nio-transport-services")
        ])
    ]

let package = Package(
    name: "BonjourDemoActorPackage",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "BonjourDemoActorSystem",
            targets: ["BonjourDemoActorSystem"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.12.0"),
            .package(url: "https://github.com/apple/swift-nio-transport-services.git", from: "1.0.0")

    ],
    targets: targets.map { target in
        var swiftSettings = target.swiftSettings ?? []
        if target.type != .plugin {
            swiftSettings.append(contentsOf: globalSwiftSettings)
        }
        if !swiftSettings.isEmpty {
            target.swiftSettings = swiftSettings
        }
        return target
    }
)
