// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenSSL",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
    ],
    products: [
        .library(name: "OpenSSL", targets: ["OpenSSL"]),
    ],
    targets: [
        .binaryTarget(
            name: "OpenSSL",
            url: "https://github.com/duckduckgo/OpenSSL-XCFramework/releases/download/1.1.2000/OpenSSL.xcframework.zip",
            checksum: "f04692e30ddbc42882f601b77759c160f6613ecdc595a9ad18891f79d87d1ac6"
        )
    ]
)
