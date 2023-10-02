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
            url: "https://github.com/duckduckgo/OpenSSL-XCFramework/releases/download/3.1.3001/OpenSSL.xcframework.zip",
            checksum: "fa23cde38eddcbb1d5e1d60bad5ceb2e923b3bd8b2461b039fe1db928bf2c80b"
        )
    ]
)
