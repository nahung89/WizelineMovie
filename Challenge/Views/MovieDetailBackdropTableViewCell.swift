//
//  MovieDetailPosterTableViewCell.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import UIKit
import Reusable

class MovieDetailBackdropTableViewCell: UITableViewCell, Reusable {

    @IBOutlet private var backdropImageView: UIImageView!

    var movie: MovieDetail? {
        didSet {
            guard let backdropPath = movie?.backdropPath else {
                clear()
                return
            }

            #warning("[!] load backdrop")
            backdropImageView.backgroundColor = UIColor.random()
            logger?.debug(backdropPath)
        }
    }

    private func clear() {
        backdropImageView.image = nil
    }
}
