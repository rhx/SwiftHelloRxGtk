// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HelloRxGtk",
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .branch("master")),
        .package(url: "https://github.com/rhx/SwiftGtk.git", .branch("master")),
        .package(url: "https://github.com/rhx/SwiftRxGtk.git", .branch("master")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "HelloRxGtk",
            dependencies: ["Gtk", "RxGtk", "RxSwift"]),
        .testTarget(
            name: "HelloRxGtkTests",
            dependencies: ["HelloRxGtk"]),
    ]
)
