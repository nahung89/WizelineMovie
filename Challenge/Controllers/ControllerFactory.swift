//
//  ControllerFactory.swift
//  Challenge
//
//  Created by Nah on 2/18/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

final class ControllerFactory {
    static func makeListMoviePresentable(_ type: MovieList.DataType) -> MovieListViewType {
        let repository = MovieListRepository(dataType: type)

        let viewModelDependency = MovieListViewModelDependency(repository: repository)
        let viewModel = MovieListViewModel(viewModelDependency)

        let dependency = MovieListViewControllerDependency(viewModel: viewModel)
        let controller = StoryboardScene.Movie.movieListViewController.instantiate()
        controller.inject(dependency)

        return controller
    }

    static func makeDetailMoviePresentable(_ movie: Movie) -> MovieDetailViewType {
        let detailRepository = MovieDetailRepository(movie: movie)
        let creditRepository = MovieCreditsRepository(movieId: movie.id)

        let viewModelDependency = MovieDetailViewModelDependency(detailRepository: detailRepository,
                                                                 creditRepository: creditRepository)
        let viewModel = MovieDetailViewModel(viewModelDependency)

        let dependency = MovieDetailViewControllerDependency(viewModel: viewModel)
        let controller = StoryboardScene.Movie.movieDetailViewController.instantiate()
        controller.inject(dependency)

        return controller
    }

    static func makeCastAndCrewPresentable(detail: MovieDetail, credits: MovieCredits) -> CastAndCrewViewType {
        let viewModelDependency = CastAndCrewViewModelDependency(detail: detail, credits: credits)
        let viewModel = CastAndCrewViewModel(viewModelDependency)

        let dependency = CastAndCrewViewControllerDependency(viewModel: viewModel)
        let controller = StoryboardScene.Movie.castAndCrewViewController.instantiate()
        controller.inject(dependency)

        return controller
    }
}
