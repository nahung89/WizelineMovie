//
//  MovieDetailTableHeaderView.swift
//  Challenge
//
//  Created by Nah on 2/20/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import UIKit
import Reusable

class MovieDetailTableHeaderView: UITableViewHeaderFooterView, NibReusable {
    var onSeeAllButtonSelect: (() -> Void)?

    @IBAction func seeAllButtonTouched(_ sender: UIButton) {
        onSeeAllButtonSelect?()
    }
}
