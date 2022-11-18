// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StringsParserPlugin",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .plugin(
            name: "StringsParserPlugin",
            targets: [ "StringsParserPlugin" ]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "StringsParserExecutable",
            dependencies:  [
                "StringsParser",
            ],
            path: "Sources/StringsParserExecutable"
        ),
        .target(name: "StringsParser",
                dependencies:  [],
                path: "Sources/StringsParser"),
        .plugin(
            name: "StringsParserPlugin",
            capability: .buildTool(),
            dependencies: [
                .target(name: "StringsParserExecutable")
            ]
        ),
        .testTarget(
            name: "StringsParserTests",
            dependencies: [ "StringsParserExecutable" ])
    ]
)
