//
//  HomeCoordinator.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

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

        router.toPresent().tabBarItem.title = makeBarTitle()
        router.setRootModule(controller, animated: false)
    }
}

private extension MovieCoordinator {
    func openDetailMovie(_ movie: Movie) {
        let controller = ControllerFactory.makeDetailMoviePresentable(movie)

        controller.onErrorReceive = { [weak self] title, error in
            self?.openAlert(title: title, error: error)
        }

        controller.onCastCrewSelect = { [weak self] detail, credits in
            self?.openCastCrew(detail, credits: credits)
        }

        router.push(controller, animated: true, hideBottomBar: true)
    }

    func openCastCrew(_ detai: MovieDetail, credits: MovieCredits) {
        logger?.warning("Implement")
    }

    func makeBarTitle() -> String {
        switch type {
        case .nowPlaying: return L10n.nowPlaying
        case .topRate: return L10n.topRated
        }
    }
}
