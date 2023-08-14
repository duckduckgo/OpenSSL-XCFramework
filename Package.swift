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
            url: "https://github.com/duckduckgo/OpenSSL-XCFramework/releases/download/1.1.2200/OpenSSL.xcframework.zip",
            checksum: "402ddb53a920d584f41ed402d2f032f9df12f04997e5633eb8bd944c16344a0d"
        )
    ]
)
