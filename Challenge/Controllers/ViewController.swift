//
//  ViewController.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import UIKit

protocol ViewControllerType: ErrorActionable {}

class ViewController: BaseViewController, ViewControllerType {
    var onErrorReceive: ((_ title: String?, _ error: Error) -> Void)?

    // MARK: - View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = UIColor.random()
    }

    // MARK: - Action

    // MARK: - Data
}
