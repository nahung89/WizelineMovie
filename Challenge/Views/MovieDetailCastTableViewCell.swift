//
//  MovieDetailCastTableViewCell.swift
//  Challenge
//
//  Created by Nah on 2/20/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import Reusable
import UIKit

class MovieDetailCastTableViewCell: UITableViewCell, Reusable {
    @IBOutlet private var castItemA: MovieDetailCastTableViewCellCastItem!
    @IBOutlet private var castItemB: MovieDetailCastTableViewCellCastItem!
    @IBOutlet private var castItemC: MovieDetailCastTableViewCellCastItem!
    @IBOutlet private var castItemD: MovieDetailCastTableViewCellCastItem!

    var casts: [MovieCredits.Cast] = [] {
        didSet {
            let views = [castItemA, castItemB, castItemC, castItemD]
            let minn = min(4, casts.count)

            for i in stride(from: 0, to: minn, by: 1) {
                views[i]?.cast = casts[i]
            }

            for i in stride(from: minn, to: 4, by: 1) {
                views[i]?.clear()
            }
        }
    }
}

class MovieDetailCastTableViewCellCastItem: UIView {
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var characterLabel: UILabel!

    var cast: MovieCredits.Cast? {
        didSet {
            guard let cast = cast else {
                clear()
                return
            }

            profileImageView.loadOrEmpty(cast.profilePath, kind: .profile)
            nameLabel.text = cast.name
            characterLabel.text = cast.character.isEmpty ? "" : "(" + cast.character + ")"
        }
    }

    fileprivate func clear() {
        profileImageView.image = nil
        nameLabel.text = ""
        characterLabel.text = ""
    }
}
