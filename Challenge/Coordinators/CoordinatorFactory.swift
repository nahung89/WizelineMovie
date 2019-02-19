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
        let router = TabbarRouter(rootController: StoryboardScene.Main.initialScene.instantiate())
        let coordinator = MainCoordinator(router: router)
        return (coordinator, router)
    }

    static func makeTopRateMoviesCoordinator() -> CoordinatorPresentable {
        let router = NavigationRouter(rootController: StoryboardScene.Movie.initialScene.instantiate())
        let coordinator = MovieCoordinator(router: router, type: .topRate)
        return (coordinator, router)
    }

    static func makeNowPlayingMoviesCoordinator() -> CoordinatorPresentable {
        let router = NavigationRouter(rootController: StoryboardScene.Movie.initialScene.instantiate())
        let coordinator = MovieCoordinator(router: router, type: .nowPlaying)
        return (coordinator, router)
    }

    static func makeErrorAlertCoordinator(title: String?, error: Error) -> CoordinatorType {
        return AlertCoordinator(title: title, error: error)
    }

    static func makeSettingCoordinator() -> CoordinatorPresentable {
        let router = NavigationRouter(rootController: StoryboardScene.Setting.initialScene.instantiate())
        let coordinator = SettingCoordinator(router: router)
        return (coordinator, router)
    }
}
