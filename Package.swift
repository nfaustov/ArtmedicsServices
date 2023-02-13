// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "ArtmedicsServices",
    platforms: [.iOS(.v13), .macOS(.v10_15)],
    products: [
        .library(
            name: "ArtmedicsServices",
            targets: ["ArtmedicsServices"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/nfaustov/Fetchworking.git", from: "0.9.0"),
    ],
    targets: [
        .target(
            name: "ArtmedicsServices",
            dependencies: [
                .product(name: "Fetchworking", package: "Fetchworking")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "ArtmedicsServicesTests",
            dependencies: ["ArtmedicsServices"]
        )
    ]
)
