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
        let controller = StoryboardScene.Main.viewController.instantiate()
        return controller
    }
}
