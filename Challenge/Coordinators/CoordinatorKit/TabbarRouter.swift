//
//  File.swift
//  iAntiTheft
//
//  Created by Nah on 1/18/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import UIKit

protocol TabbarRouterType: RouterType {
    func toPresent() -> UITabBarController

    func selectModule(at index: Int)
    func setModules(_ modules: [Presentable], animated: Bool)
}

final class TabbarRouter: Router, TabbarRouterType {
    private let rootController: UITabBarController

    init(rootController: UITabBarController) {
        self.rootController = rootController
        super.init(rootController: rootController)
    }

    override func toPresent() -> UITabBarController {
        return rootController
    }

    // MARK: - Tabbar

    func selectModule(at index: Int) {
        rootController.selectedIndex = index
    }

    func setModules(_ modules: [Presentable], animated: Bool) {
        let controllers = modules.map({ $0.toPresent() })
        rootController.setViewControllers(controllers, animated: animated)
    }
}
