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
            url: "https://github.com/duckduckgo/OpenSSL-XCFramework/releases/download/3.1.6000/OpenSSL.xcframework.zip",
            checksum: "d6bb911d4905714b166ae8f015df848577998f84dabf5c59a74d0c4bf8350e17"
        )
    ]
)
