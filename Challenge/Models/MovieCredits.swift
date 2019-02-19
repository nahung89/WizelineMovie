//
//  MovieCredits.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

struct MovieCredits: Decodable {
    let id: Int
    let casts: [Cast]
    let crews: [Crew]

    private enum CodingKeys: String, CodingKey {
        case id
        case casts = "cast"
        case crews = "crew"
    }
}

extension MovieCredits {
    struct Cast: Decodable {
        let id: Int
        let character: String
        let name: String
        let profilePath: String?

        private enum CodingKeys: String, CodingKey {
            case id, name, character
            case profilePath = "profile_path"
        }
    }

    struct Crew: Decodable {
        let id: Int
        let name: String
        let job: String
        let profilePath: String?

        private enum CodingKeys: String, CodingKey {
            case id, name, job
            case profilePath = "profile_path"
        }
    }
}
