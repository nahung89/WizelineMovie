//
//  Movie.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

struct Movie: MovieType, Decodable {
    let id: Int
    let title: String
    let voteAverage: Double
    let totalVotes: Int
    let posterPath: String?
    let backdropPath: String?
    let overview: String
    let releaseDate: Date

    private enum CodingKeys: String, CodingKey {
        case id, title, overview
        case voteAverage = "vote_average"
        case totalVotes = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }
}
