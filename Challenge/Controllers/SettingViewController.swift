//
//  SettingViewController.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

protocol SettingViewType: ErrorActionable {
    var onDoneSelect: (() -> Void)? { get set }
}

typealias SettingViewControllerDependency = SettingViewController.Dependency
extension SettingViewController {
    struct Dependency {
        let viewModel: SettingViewModel
    }
}

class SettingViewController: BaseViewController, SettingViewType {
    var onErrorReceive: ((_ title: String?, _ error: Error) -> Void)?
    var onDoneSelect: (() -> Void)?

    private var viewModel: SettingViewModel!
    private let disposeBag = DisposeBag()

    // MARK: - View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
    }

    // MARK: - Setup

    func inject(_ dependency: Dependency) {
        viewModel = dependency.viewModel
    }

    private func setupUI() {
        navigationItem.title = L10n.setting
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: L10n.done, style: .plain, target: nil, action: nil)
    }

    private func setupBinding() {
        guard viewModel != nil else { fatalError("viewModel non-existed") }

        navigationItem.rightBarButtonItem?.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.onDoneSelect?()
            }).disposed(by: disposeBag)
    }
}
