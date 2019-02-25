//
//  CoordinatorType.swift
//  Challenge
//
//  Created by Nah on 2/25/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

protocol CoordinatorType: AnyObject {
    var childCoordinators: [CoordinatorType] { get }

    var finishCallback: ((CoordinatorType) -> Void)? { get set }

    func start()

    func addDependency(_ coordinator: CoordinatorType)
    func removeDependency(_ coordinator: CoordinatorType)
    func removeAllDependencies()
}
