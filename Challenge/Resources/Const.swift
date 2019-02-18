//
//  Const.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import UIKit

enum LogConfig {
    static let directoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("Logs", isDirectory: true)
    static let fileUrl = directoryUrl.appendingPathComponent("\(UIDevice.current.name)-\(Date()).log")
    static let sizesLimit = 1 * 1024 * 1024 // 1MB
    static let filesLimit: Int = 50 // 50 files
}
