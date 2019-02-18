//
//  CoordinatorProtocols.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

protocol CoordinatorErrorable: CoordinatorType {
    func openAlert(title: String?, error: Error)
}

extension CoordinatorErrorable where Self: Coordinator {
    func openAlert(title: String?, error: Error) {
        let coordinator = CoordinatorFactory.makeErrorAlertCoordinator(title: title, error: error)

        coordinator.finishCallback = { [unowned self] caller in
            self.removeDependency(caller)
        }

        addDependency(coordinator)
        coordinator.start()
    }
}
