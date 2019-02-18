//
//  ControllerFactory.swift
//  Challenge
//
//  Created by Nah on 2/18/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

final class ControllerFactory {
    static func makeSamplePresentable() -> ViewControllerType {
        let repository = SampleRepository()
        let viewModelDependency = SampleViewModelDependency(repository: repository)
        let viewModel = SampleViewModel(viewModelDependency)
        let dependency = SampleViewControllerDependency(viewModel: viewModel)

        let controller = StoryboardScene.Main.sampleViewController.instantiate()
        controller.inject(dependency)
        return controller
    }
}
