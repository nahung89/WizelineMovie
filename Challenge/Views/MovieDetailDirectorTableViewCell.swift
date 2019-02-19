//
//  MovieDetailDirectorTableViewCell.swift
//  Challenge
//
//  Created by Nah on 2/20/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import Reusable
import UIKit

class MovieDetailDirectorTableViewCell: UITableViewCell, Reusable {
    @IBOutlet private var directorLabel: UILabel!

    var crews: [MovieCredits.Crew] = [] {
        didSet {
            directorLabel.text = contentText
        }
    }

    var contentText: String {
        let directorNames = crews.filter({ $0.job.lowercased() == "director" })

        let text: String
        switch directorNames.count {
        case 0:
            assertionFailure("must have at least 1 director")
            text = ""

        case 1:
            text = "Director: \(directorNames[0].name)"

        case 2:
            text = "Directors: \(directorNames[0].name) & \(directorNames[1].name)"

        default:
            text = "Directors: \(directorNames[0].name) & \(directorNames.count - 1) more"
        }
        
        return text
    }
}
