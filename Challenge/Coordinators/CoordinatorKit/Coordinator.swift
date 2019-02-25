//
//  Coordinator.swift
//  iAntiTheft
//
//  Created by Nah on 1/5/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

class Coordinator: NSObject, CoordinatorType {
    private(set) var childCoordinators: [CoordinatorType] = []

    var finishCallback: ((CoordinatorType) -> Void)?

    override init() {
        super.init()
        logger?.severe(typeName)
    }

    deinit {
        logger?.severe(typeName)
    }

    func start(_ option: DeepLinkOption?) {
        assertionFailure("Function need to be overrided.")
    }

    func handle(_ option: DeepLinkOption) -> Bool {
        assertionFailure("Function need to be overrided.")
        return false
    }

    func addDependency(_ coordinator: CoordinatorType) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: CoordinatorType) {
        guard
            !childCoordinators.isEmpty,
            childCoordinators.contains(where: { $0 === coordinator })
            else { return }

        // Clear child-coordinators recursively
        coordinator.removeAllDependencies()
        childCoordinators.removeAll(where: { $0 === coordinator })
    }

    func removeAllDependencies() {
        guard !childCoordinators.isEmpty else { return }
        childCoordinators.reversed().forEach({ removeDependency($0) })
    }
}
