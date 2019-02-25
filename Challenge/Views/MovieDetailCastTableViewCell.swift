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

protocol MovieDetailCastTableViewCellDelegate: AnyObject {
    func movieDetailCastTableViewCell(_ cell: MovieDetailCastTableViewCell, didSelect cast: MovieCredits.Cast)
}

extension MovieDetailCastTableViewCellDelegate {
    func movieDetailCastTableViewCell(_ cell: MovieDetailCastTableViewCell, didSelect cast: MovieCredits.Cast) {}
}

class MovieDetailCastTableViewCell: UITableViewCell, Reusable, ViewSuspendable {
    @IBOutlet private var castItemA: MovieDetailCastTableViewCellCastItem!
    @IBOutlet private var castItemB: MovieDetailCastTableViewCellCastItem!
    @IBOutlet private var castItemC: MovieDetailCastTableViewCellCastItem!
    @IBOutlet private var castItemD: MovieDetailCastTableViewCellCastItem!

    weak var delegate: MovieDetailCastTableViewCellDelegate?

    var casts: [MovieCredits.Cast] = [] {
        didSet {
            let views = [castItemA, castItemB, castItemC, castItemD]
            let minn = min(4, casts.count)

            for i in stride(from: 0, to: minn, by: 1) {
                views[i]?.cast = casts[i]
            }

            for i in stride(from: minn, to: 4, by: 1) {
                views[i]?.cast = nil
                views[i]?.clear()
            }
        }
    }

    func suspend() {
        [castItemA, castItemB, castItemC, castItemD].forEach({ $0?.suspend() })
    }

    @IBAction private func onItemTouch(_ sender: MovieDetailCastTableViewCellCastItem) {
        guard let cast = sender.cast else { return }
        delegate?.movieDetailCastTableViewCell(self, didSelect: cast)
    }
}

class MovieDetailCastTableViewCellCastItem: UIButton, ViewSuspendable {
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

    func suspend() {
        profileImageView.kf.cancelDownloadTask()
    }
}
