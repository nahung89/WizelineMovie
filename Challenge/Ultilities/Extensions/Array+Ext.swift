//
//  Array+Ext.swift
//  iAntiTheft
//
//  Created by Nah on 4/7/18.
//  Copyright © 2018 Nah. All rights reserved.
//

import Foundation

extension Array {
    func get(at index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}
