//
//  Presentable.swift
//  iAntiTheft
//
//  Created by Nah on 1/5/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import UIKit

protocol Presentable: AnyObject {
    func toPresent() -> UIViewController
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController {
        return self
    }
}
