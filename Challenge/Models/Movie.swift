//
//  Movie.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

protocol MovieType {
    var id: Int { get }
    var title: String { get }
    var voteAverage: Double { get }
    var totalVotes: Double { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var overview: String { get }
    var releaseDate: Date { get }
}

struct Movie: MovieType, Decodable {
    let id: Int
    let title: String
    let voteAverage: Double
    let totalVotes: Double
    let posterPath: String?
    let backdropPath: String?
    let overview: String
    let releaseDate: Date

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteAverage = "vote_average"
        case totalVotes = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
    }
}
