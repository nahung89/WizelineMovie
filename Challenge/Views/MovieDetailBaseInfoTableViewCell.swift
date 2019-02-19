//
//  MovieDetailBaseInfoTableViewCell.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import DateHelper
import Foundation
import Reusable
import UIKit

class MovieDetailBaseInfoTableViewCell: UITableViewCell, Reusable {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!

    var movie: MovieDetail? {
        didSet {
            guard let movie = movie else {
                clear()
                return
            }

            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.hour, .minute]

            var duration = ""
            if let time = movie.duration {
                duration = "\(time)m"
            }

            let genres = movie.genres.map({ $0.name }).joined(separator: ", ")

            titleLabel.text = "\(movie.title) (\(movie.releaseDate.toString(format: .isoYear)))"
            contentLabel.text = ["★ \(movie.voteAverage)/10", duration, genres].filter({ !$0.isEmpty }).joined(separator: " | ")
        }
    }

    private func clear() {
        titleLabel.text = ""
        contentLabel.text = ""
    }
}
