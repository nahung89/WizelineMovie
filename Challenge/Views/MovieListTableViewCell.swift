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
    @IBOutlet private var posterImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var releaseDateLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var summaryLabel: UILabel!
    @IBOutlet private var posterWidthConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        posterWidthConstraint.constant = UIScreen.main.bounds.width / 4
    }

    var movie: Movie? {
        didSet {
            guard let movie = movie else {
                clear()
                return
            }

            posterImageView.loadOrEmpty(movie.posterPath, kind: .poster)
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate.toString(format: .isoYear)
            summaryLabel.text = movie.overview

            let voteAverage = String(format: "%.1f", movie.voteAverage)
            let totalVotes = "\(movie.totalVotes) \(movie.totalVotes > 1 ? L10n.votes : L10n.vote)"
            ratingLabel.text = "★ \(voteAverage) (\(totalVotes))"
        }
    }

    private func clear() {
        posterImageView.image = nil
        titleLabel.text = ""
        ratingLabel.text = ""
        releaseDateLabel.text = ""
    }
}
