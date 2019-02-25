//
//  SettingCoordinator.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

class SettingCoordinator: Coordinator, CoordinatorErrorable {
    private let router: NavigationRouterType

    init(router: NavigationRouterType) {
        self.router = router
        super.init()
    }

    override func start() {
        let controller = ControllerFactory.makeSettingPresentable()

        controller.onErrorReceive = { [weak self] title, error in
            self?.openAlert(title: title, error: error)
        }

        controller.onDoneSelect = { [weak self] in
            self?.finish(animated: true)
        }

        router.setRootModule(controller, animated: false)
    }

    private func finish(animated: Bool) {
        removeAllDependencies()
        router.dismissModule(animated: animated, completion: { [weak self] in
            guard let `self` = self else { return }
            self.finishCallback?(self)
        })
    }
}
