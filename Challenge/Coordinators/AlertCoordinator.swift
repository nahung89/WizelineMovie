//
//  ErrorCoordinator.swift
//  iAntiTheft
//
//  Created by Nah on 1/8/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import UIKit

final class AlertCoordinator: Coordinator {
    enum Value {
        case error(String?, Error)
    }

    private let window = UIWindow(frame: UIScreen.main.bounds)
    private let value: Value

    init(value: Value) {
        self.value = value
        super.init()
    }

    override func start(_ option: DeepLinkOption?) {
        let presentable: Presentable
        switch value {
        case let .error(title, error):
            presentable = createError(title: title ?? L10n.error, message: error.localizedDescription)
        }

        window.windowLevel = .alert + 1
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        window.rootViewController?.present(presentable.toPresent(), animated: true)
    }

    override func handle(_ option: DeepLinkOption) -> Bool {
        finish(animated: false)
        return true
    }

    private func finish(animated: Bool) {
        window.rootViewController?.dismiss(animated: animated)
        window.resignKey()
        finishCallback?(self)
    }
}

private extension AlertCoordinator {
    func createError(title: String?, message: String) -> Presentable {
        let action = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            self?.finish(animated: true)
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(action)

        return alertController
    }
}
