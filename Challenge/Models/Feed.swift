//
//  Feed.swift
//  Challenge
//
//  Created by Nah on 2/20/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

enum Feed {
    case movie(Movie)
    case ad(Advertise)

    var isAd: Bool {
        switch self {
        case .ad:
            return true
        case .movie:
            return false
        }
    }
}
