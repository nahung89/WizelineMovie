//
//  Optional+Ext.swift
//  iAntiTheft
//
//  Created by Nah on 3/27/18.
//  Copyright © 2018 Nah. All rights reserved.
//

import Foundation

extension Optional {
    var logable: Any {
        switch self {
        case .none:
            return "🐙🧨⭕️"
        case let .some(value):
            return value
        }
    }
}
