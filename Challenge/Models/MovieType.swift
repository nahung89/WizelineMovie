//
//  MovieType.swift
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
    var totalVotes: Int { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var overview: String { get }
    var releaseDate: Date { get }
}
