//
//  ListMovie.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

struct MovieList: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case movies = "results"
    }
}

// {
//    "page": 1,
//    "total_results": 6910,
//    "total_pages": 346,
//    "results": [...]
// }
