// swift-tools-version: 5.10
import PackageDescription

let package = Package(
  name: "workout",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    // xtool builds this product into the app
    .library(name: "workout", targets: ["workout"])
  ],
  targets: [
    // Your app
    .target(
      name: "workout",
      dependencies: ["UltralyticsYOLO"],
      
    ),
    // The YOLO library you already have
    .target(
      name: "UltralyticsYOLO",
      exclude: ["README.md"]
    ),
  ]
)