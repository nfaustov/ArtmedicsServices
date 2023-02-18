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
        .package(url: "https://github.com/nfaustov/ArtmedicsCore.git", from: "0.11.1")
    ],
    targets: [
        .target(
            name: "ArtmedicsServices",
            dependencies: [
                .product(name: "Fetchworking", package: "Fetchworking"),
                .product(name: "ArtmedicsCore", package: "ArtmedicsCore")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "ArtmedicsServicesTests",
            dependencies: ["ArtmedicsServices"]
        )
    ]
)
