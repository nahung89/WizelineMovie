//
//  MovieDetailPosterTableViewCell.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import Reusable
import UIKit

class MovieDetailBackdropTableViewCell: UITableViewCell, Reusable, ViewSuspendable {
    @IBOutlet private var backdropImageView: UIImageView!

    var movie: MovieDetail? {
        didSet {
            guard let movie = movie else {
                clear()
                return
            }
            backdropImageView.loadOrEmpty(movie.backdropPath, kind: .backdrop)
        }
    }

    private func clear() {
        backdropImageView.image = nil
    }

    func suspend() {
        backdropImageView.kf.cancelDownloadTask()
    }
}
