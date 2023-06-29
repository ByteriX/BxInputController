// swift-tools-version:5.4
/**
 *	@file Package.swift
 *	@namespace BxInputController
 *
 *	@details Swift packege manager file
 *	@date 14.02.2017
 *	@author Sergey Balalaev
 *
 *	@version last in https://github.com/ByteriX/BxInputController.git
 *	@copyright The MIT License (MIT) https://opensource.org/licenses/MIT
 *	 Copyright (c) 2017 ByteriX. See http://byterix.com
 */

import PackageDescription

let package = Package(
    name: "BxInputController",
    defaultLocalization: "ru",
    platforms: [.iOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BxInputController",
            targets: ["BxInputController"]),
//        .library(
//            name: "BxInputControllerPhoto",
//            targets: ["BxInputController", "BxInputControllerPhoto"]),
    ],
    dependencies: [
        // not compile from version
        //.package(url: "https://github.com/ByteriX/BxObjC.git", from: "1.0.0"),
        .package(url: "https://github.com/ByteriX/BxObjC.git", .branch("master")),
        .package(url: "https://github.com/ByteriX/BxTextField.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BxInputController",
            dependencies: [
                "BxObjC",

//                .product(name: "BxObjC/Common", package: "BxObjC"),
//                .product(name: "BxObjC/Control/Rate", package: "BxObjC"),
//                .product(name: "BxObjC/Control/TextView", package: "BxObjC"),
//                .product(name: "BxObjC/Control/ShakeAnimation", package: "BxObjC"),
//                .product(name: "BxObjC/Control/Navigation", package: "BxObjC"),



//                .byName(name: "BxObjC/Common"),
//                .byName(name: "BxObjC/Common"),
//                .byName(name: "BxObjC/Control/Rate"),
//                .byName(name: "BxObjC/Control/TextView"),
//                .byName(name: "BxObjC/Control/ShakeAnimation"),
//                .byName(name: "BxObjC/Control/Navigation"),
                "BxTextField"
            ],
            path: "BxInputController/Sources"
//            ,
//            exclude: ["Rows/Pictures"]
        ),
//        .target(
//            name: "BxInputControllerPhoto",
//            dependencies: ["BxInputController"],
//            path: "BxInputController/Sources/Rows/Pictures")
    ],
    swiftLanguageVersions: [.v5]
)
