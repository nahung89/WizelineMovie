//
//  MainCoordinator.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

class MainCoordinator: Coordinator {
    private let router: TabbarRouterType

    init(router: TabbarRouterType) {
        self.router = router
        super.init()
    }

    override func start(_ option: DeepLinkOption?) {
        let factory = CoordinatorFactory.self
        let instances = [factory.makeNowPlayingMoviesCoordinator(),
                         factory.makeTopRateMoviesCoordinator()]

        // Assign `viewControllers` will make `viewDidLoad` run automatically
        router.setModules(instances.map({ $0.presentable }), animated: false)

        // Only start each coordinator after its presentable is in `tabBarController`
        for coordinator in instances.map({ $0.coordinator }) {
            coordinator.finishCallback = { [unowned self] caller in
                self.removeDependency(caller)
            }
            addDependency(coordinator)
            coordinator.start()
        }
    }
}
