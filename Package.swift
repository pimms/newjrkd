// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swiftserver",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura", from: "2.9.1"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.9.0"),
        .package(url: "https://github.com/ShawnMoore/XMLParsing.git", from: "0.0.3"),
    ],
    targets: [
        .target(name: "swiftserver", dependencies: [ .target(name: "Application"), "Kitura", "XMLParsing"]),
        .target(name: "Application", dependencies: [ "Kitura", "HeliumLogger" ]),

        .testTarget(name: "ApplicationTests", dependencies: [ .target(name: "Application"), "Kitura", "XMLParsing" ]),
    ]
)
