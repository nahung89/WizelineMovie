//
//  ServerConfiguration.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

struct Configuration: Codable {
    let image: Image

    private enum CodingKeys: String, CodingKey {
        case image = "images"
    }
}

extension Configuration {
    struct Image: Codable {
        let baseUrl: URL
        let backdropSizes: [String]
        let posterSizes: [String]
        let profileSizes: [String]

        private enum CodingKeys: String, CodingKey {
            case baseUrl = "secure_base_url"
            case backdropSizes = "backdrop_sizes"
            case posterSizes = "poster_sizes"
            case profileSizes = "profile_sizes"
        }
    }
}
