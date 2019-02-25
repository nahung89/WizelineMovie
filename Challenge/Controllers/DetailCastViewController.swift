//
//  DetailCastViewController.swift
//  Challenge
//
//  Created by Nah on 2/25/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import UIKit

protocol DetailCastViewType: Presentable {}

class DetailCastViewController: BaseViewController, DetailCastViewType {

    private var cast: MovieCredits.Cast!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.random()
        navigationItem.title = cast.name
    }

    func inject(_ dependency: MovieCredits.Cast) {
        // TODO: Simply assign data directly.
        // If we need to handle more data actions, better to make ViewModel for it.
        cast = dependency
    }
}
