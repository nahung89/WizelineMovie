//
//  Const.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import UIKit

enum APIConst {
    static let BaseURLPath = "https://api.themoviedb.org/3"
    static let Key = "31b9e98ad4dcd29fa0cd622b3efc4d1b"
}

enum ImageConst {
    static let Setting = "configuration.json"
    static let Scheme = "https://image.tmdb.org/t/p/original"
    static let Size = "original"
    static let UserDefaultKey = "ImageConfiguration"
}

enum LogConfig {
    static let DirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Logs", isDirectory: true)
    static let FileUrl = DirectoryUrl.appendingPathComponent("\(UIDevice.current.name)-\(Date()).log")
    static let SizesLimit = 1 * 1024 * 1024 // 1MB
    static let FilesLimit: Int = 50 // 50 files
}
