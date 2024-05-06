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
            url: "https://github.com/duckduckgo/OpenSSL-XCFramework/releases/download/3.1.5004/OpenSSL.xcframework.zip",
            checksum: "9b9f5579cd7e1e3c22cae3d63b1647f3f7358367ae39515904a3d6fb083d0db3"
        )
    ]
)
