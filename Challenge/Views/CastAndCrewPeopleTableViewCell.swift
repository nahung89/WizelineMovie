//
//  CastAndCrewPeopleTableViewCell.swift
//  Challenge
//
//  Created by Nah on 2/20/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import Reusable
import UIKit

class CastAndCrewPeopleTableViewCell: UITableViewCell, Reusable, ViewSuspendable {
    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var profileWidthConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileWidthConstraint.constant = UIScreen.main.bounds.width / 4
    }

    var person: Person? {
        didSet {
            guard let person = person else {
                clear()
                return
            }

            profileImageView.loadOrEmpty(person.profilePath, kind: .profile)
            nameLabel.text = person.name
            titleLabel.text = person.title
        }
    }

    private func clear() {
        profileImageView.image = nil
        nameLabel.text = ""
        titleLabel.text = ""
    }

    func suspend() {
        profileImageView.kf.cancelDownloadTask()
    }
}
