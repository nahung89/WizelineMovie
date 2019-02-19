//
//  AppCoordinator.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

final class AppCoordinator: Coordinator, CoordinatorErrorable {
    private let window: UIWindow
    private let disposeBag = DisposeBag()

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start(_ option: DeepLinkOption?) {
        let (coordinator, presentable) = CoordinatorFactory.makeMainCoordinator()

        coordinator.finishCallback = { [unowned self] caller in
            self.removeDependency(caller)
        }

        window.rootViewController = presentable.toPresent()
        window.makeKeyAndVisible()

        addDependency(coordinator)
        coordinator.start()
    }
}

extension AppCoordinator {
    func printOut() {
        logger?.info(structure(coordinator: self, level: 1))
    }

    private func structure(coordinator: Coordinator, level: Int) -> String {
        let prefix = stride(from: 0, to: level, by: 1).map({ _ in "    " }).joined()
        var str = "\n\(prefix)\(level).\(coordinator)"

        for c in coordinator.childCoordinators {
            str += structure(coordinator: c as! Coordinator, level: level + 1)
        }
        return str
    }
}
