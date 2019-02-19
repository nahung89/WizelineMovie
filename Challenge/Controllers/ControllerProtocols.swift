//
//  ControllerProtocols.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

protocol ErrorActionable: Presentable {
    var onErrorReceive: ((_ title: String?, _ error: Error) -> Void)? { get set }
}

protocol SettingActionable: Presentable {
    var onSettingSelect: (() -> Void)? { get set }
}
