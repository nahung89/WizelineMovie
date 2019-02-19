//
//  MovieDetail.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

struct MovieDetail: MovieType, Decodable {
    let id: Int
    let title: String
    let duration: Int?
    let voteAverage: Double
    let totalVotes: Double
    let posterPath: String?
    let backdropPath: String?
    let overview: String
    let releaseDate: Date
    let genres: [MovieGenre]

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteAverage = "vote_average"
        case totalVotes = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case genres
        case duration = "runtime"
    }
}

extension MovieDetail {
    init(movie: Movie) {
        self.init(id: movie.id,
                  title: movie.title,
                  duration: nil,
                  voteAverage: movie.voteAverage,
                  totalVotes: movie.totalVotes,
                  posterPath: movie.posterPath,
                  backdropPath: movie.backdropPath,
                  overview: movie.overview,
                  releaseDate: movie.releaseDate,
                  genres: [])
    }
}
