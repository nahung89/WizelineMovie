//
//  HomeCoordinator.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

class MovieListCoordinator: Coordinator, CoordinatorErrorable {
    let type: MovieList.DataType

    private let router: NavigationRouterType

    init(router: NavigationRouterType, type: MovieList.DataType) {
        self.type = type
        self.router = router
    }

    override func start(_ option: DeepLinkOption?) {
        router.toPresent().tabBarItem.title = barTitle()

        let controller = ControllerFactory.makeListMoviePresentable(type)

        controller.onErrorReceive = { [weak self] title, error in
            self?.openAlert(title: title, error: error)
        }

        controller.onMovieSelect = { [weak self] movie in
            self?.goToDetailMovie(movie)
        }

        router.setRootModule(controller, animated: false)
    }
}

private extension MovieListCoordinator {
    func goToDetailMovie(_ movie: Movie) {
        logger?.info("Select \(movie)")
    }

    func barTitle() -> String {
        switch type {
        case .nowPlaying: return L10n.nowPlayingBar
        case .topRate: return L10n.topRateBar
        }
    }
}
