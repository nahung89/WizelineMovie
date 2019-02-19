//
//  MainCoordinator.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

class MainCoordinator: Coordinator, CoordinatorErrorable {
    private let router: NavigationRouterType

    init(router: NavigationRouterType) {
        self.router = router
    }

    override func start(_ option: DeepLinkOption?) {
        let controller = ControllerFactory.makeListMoviePresentable()

        controller.onErrorReceive = { [weak self] title, error in
            self?.openAlert(title: title, error: error)
        }

        router.setRootModule(controller, animated: false)
    }
}
