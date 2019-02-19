//
//  UIColor+Ext.swift
//  iAntiTheft
//
//  Created by Nah on 3/27/18.
//  Copyright © 2018 Nah. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func random(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: CGFloat(arc4random() % 256) / 256,
                       green: CGFloat(arc4random() % 256) / 256,
                       blue: CGFloat(arc4random() % 256) / 256,
                       alpha: alpha)
    }
}
