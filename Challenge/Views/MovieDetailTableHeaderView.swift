//
//  MovieDetailTableHeaderView.swift
//  Challenge
//
//  Created by Nah on 2/20/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import Reusable
import UIKit

class MovieDetailTableHeaderView: UITableViewHeaderFooterView, NibReusable {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var nextButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = L10n.castAndCrews
        nextButton.setTitle(L10n.seeAll, for: .normal)
    }

    var onSeeAllButtonSelect: (() -> Void)?

    @IBAction func seeAllButtonTouched(_ sender: UIButton) {
        onSeeAllButtonSelect?()
    }
}
