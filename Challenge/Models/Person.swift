//
//  Profile.swift
//  Challenge
//
//  Created by Nah on 2/20/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

struct Person {
    let name: String
    let title: String
    let profilePath: String?
}

extension Person {
    init(_ crew: MovieCredits.Crew) {
        self.init(name: crew.name, title: crew.job, profilePath: crew.profilePath)
    }

    init(_ cast: MovieCredits.Cast) {
        self.init(name: cast.name, title: cast.character, profilePath: cast.profilePath)
    }
}
