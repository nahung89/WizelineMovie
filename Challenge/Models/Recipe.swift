//
//  Recipe.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

struct Recipe: Decodable {
    let publisher: String
    let url: URL
    let sourceUrl: String
    let id: String
    let title: String
    let imageUrl: URL
    let socialRank: Double
    let publisherUrl: URL

    private enum CodingKeys: String, CodingKey {
        case publisher
        case url = "f2f_url"
        case sourceUrl = "source_url"
        case id = "recipe_id"
        case title
        case imageUrl = "image_url"
        case socialRank = "social_rank"
        case publisherUrl = "publisher_url"
    }
}
