//
//  MovieDetailSumaryTableViewCell.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import Reusable
import UIKit

class MovieDetailSumaryTableViewCell: UITableViewCell, Reusable {
    @IBOutlet private var summaryLabel: UILabel!

    var movie: MovieDetail? {
        didSet {
            guard let movie = movie else {
                clear()
                return
            }

            summaryLabel.text = movie.overview
        }
    }

    private func clear() {
        summaryLabel.text = ""
    }
}
