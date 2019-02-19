//
//  MovieListTableViewCell.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import Reusable
import UIKit

class MovieListTableViewCell: UITableViewCell, Reusable {
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var totalVoteLabel: UILabel!
    @IBOutlet private var releaseDateLabel: UILabel!

    var movie: Movie? {
        didSet {
            guard let movie = movie else {
                clear()
                return
            }

            posterImageView.backgroundColor = UIColor.random()
            titleLabel.text = movie.title
            ratingLabel.text = "\(movie.voteAverage)"
            totalVoteLabel.text = "\(movie.totalVotes)"
            releaseDateLabel.text = movie.releaseDate
        }
    }

    private func clear() {
        posterImageView.image = nil
        titleLabel.text = ""
        ratingLabel.text = ""
        totalVoteLabel.text = ""
        releaseDateLabel.text = ""
    }
}
