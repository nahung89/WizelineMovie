//
//  Movie.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let voteAverage: Double
    let totalVotes: Double
    let posterPath: String?; #warning("Update to `URL`")
    let backdropPath: String?; #warning("Update to `URL`")
    let overview: String
    let releaseDate: String; #warning("Update to `DateTime`")

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

// {
//    "vote_count": 1978,
//    "id": 19404,
//    "video": false,
//    "vote_average": 9.1,
//    "title": "Dilwale Dulhania Le Jayenge",
//    "popularity": 16.603,
//    "poster_path": "\/uC6TTUhPpQCmgldGyYveKRAu8JN.jpg",
//    "original_language": "hi",
//    "original_title": "दिलवाले दुल्हनिया ले जायेंगे",
//    "genre_ids": [
//    35,
//    18,
//    10749
//    ],
//    "backdrop_path": "\/nl79FQ8xWZkhL3rDr1v2RFFR6J0.jpg",
//    "adult": false,
//    "overview": "Raj is a rich, carefree, happy-go-lucky second generation NRI. Simran is the daughter of Chaudhary Baldev Singh, who in spite of being an NRI is very strict about adherence to Indian values. Simran has left for India to be married to her childhood fiancé. Raj leaves for India with a mission at his hands, to claim his lady love under the noses of her whole family. Thus begins a saga.",
//    "release_date": "1995-10-20"
// }
