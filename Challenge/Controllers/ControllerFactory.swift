//
//  ControllerFactory.swift
//  Challenge
//
//  Created by Nah on 2/18/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

final class ControllerFactory {
    static func makeListMoviePresentable() -> MovieListViewType {
        let repository = MovieListRepository()
        let viewModelDependency = MovieListViewModelDependency(repository: repository)
        let viewModel = MovieListViewModel(viewModelDependency)
        let dependency = MovieListViewControllerDependency(viewModel: viewModel)

        let controller = StoryboardScene.Main.movieListViewController.instantiate()
        controller.inject(dependency)
        return controller
    }
}
