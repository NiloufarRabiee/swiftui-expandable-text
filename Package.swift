// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ExpandableText",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "ExpandableText",
            targets: ["ExpandableText"]
        )
    ],
    targets: [
        .target(
            name: "ExpandableText"
        ),
        .testTarget(
            name: "ExpandableTextTests",
            dependencies: ["ExpandableText"]
        )
    ]
)
