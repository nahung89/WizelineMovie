//
//  AppDelegate+Config.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import Kingfisher
import XCGLogger

let logger: XCGLogger? = XCGLogger.customize()

extension AppDelegate {
    func config() {
        // 50 MB
        ImageCache.default.diskStorage.config.sizeLimit = UInt(50 * 1024 * 1024)

        // Make instance to prepare data before app showing
        _ = ImageService.shared
    }
}
