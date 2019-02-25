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
    case textAd(TextAdvertise)
    case imageAd(ImageAdvertise)
    case imageTextAd(ImageTextAdvertise)
    case videoAd(VideoAdvertise)

    var isAd: Bool {
        switch self {
        case .textAd, .imageAd, .imageTextAd, .videoAd:
            return true
        case .movie:
            return false
        }
    }
}
