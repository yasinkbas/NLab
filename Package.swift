// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NLab",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_11)
    ],
    products: [
        .library(
            name: "NLab",
            targets: ["NLab"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "NLab",
            dependencies: []),
//        .testTarget(
//            name: "NLabTests",
//            dependencies: ["NLab"]),
    ]
)
