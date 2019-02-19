//
//  CoordinatorFactory.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
import UIKit

typealias CoordinatorPresentable = (coordinator: CoordinatorType, presentable: Presentable)

final class CoordinatorFactory {
    static func makeMainCoordinator() -> CoordinatorPresentable {
        let router = NavigationRouter(rootController: StoryboardScene.Main.initialScene.instantiate())
        let coordinator = MainCoordinator(router: router)
        return (coordinator, router)
    }

    static func makeErrorAlertCoordinator(title: String?, error: Error) -> CoordinatorType {
        return AlertCoordinator(value: .error(title, error))
    }
}