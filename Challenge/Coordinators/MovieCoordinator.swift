//
//  HomeCoordinator.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import UIKit

class MovieCoordinator: Coordinator, CoordinatorErrorable {
    let type: MovieList.DataType

    private let router: NavigationRouterType

    init(router: NavigationRouterType, type: MovieList.DataType) {
        self.type = type
        self.router = router
        super.init()
    }

    override func start(_ option: DeepLinkOption?) {
        let controller = ControllerFactory.makeListMoviePresentable(type)

        controller.onErrorReceive = { [weak self] title, error in
            self?.openAlert(title: title, error: error)
        }

        controller.onMovieSelect = { [weak self] movie in
            self?.openDetailMovie(movie)
        }

        controller.onSettingSelect = { [weak self] in
            self?.openSetting()
        }

        router.toPresent().tabBarItem = makeBarTitle()
        router.setRootModule(controller, animated: false)
    }
}

private extension MovieCoordinator {
    func openDetailMovie(_ movie: Movie) {
        let controller = ControllerFactory.makeDetailMoviePresentable(movie)

        controller.onErrorReceive = { [weak self] title, error in
            self?.openAlert(title: title, error: error)
        }

        controller.onAllCastCrewSelect = { [weak self] detail, credits in
            self?.openCastCrew(detail, credits: credits)
        }

        controller.onDetailCastSelect = { [weak self] cast in
            self?.openCast(cast)
        }

        controller.onSettingSelect = { [weak self] in
            self?.openSetting()
        }

        router.push(controller, animated: true, hideBottomBar: true)
    }

    func openCastCrew(_ detail: MovieDetail, credits: MovieCredits) {
        let controller = ControllerFactory.makeCastAndCrewPresentable(detail: detail, credits: credits)

        controller.onSettingSelect = { [weak self] in
            self?.openSetting()
        }

        router.push(controller, animated: true, hideBottomBar: true)
    }

    func openCast(_ cast: MovieCredits.Cast) {
        let controller = ControllerFactory.makeDetailCastPresentable(cast: cast)
        router.push(controller, animated: true, hideBottomBar: true)
    }

    func openSetting() {
        let (coordinator, presentable) = CoordinatorFactory.makeSettingCoordinator()

        coordinator.finishCallback = { [unowned self] caller in
            self.removeDependency(caller)
        }

        router.present(presentable, animated: true)
        addDependency(coordinator)
        coordinator.start()
    }

    func makeBarTitle() -> UITabBarItem {
        let item: UITabBarItem
        switch type {
        case .nowPlaying:
            item = UITabBarItem(title: L10n.nowPlaying, image: Asset.nowPlaying.image, tag: 0)
        case .topRate:
            item = UITabBarItem(title: L10n.topRated, image: Asset.topRate.image, tag: 1)
        }
        return item
    }
}
