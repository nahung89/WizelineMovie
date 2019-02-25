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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.random()
    }
}
