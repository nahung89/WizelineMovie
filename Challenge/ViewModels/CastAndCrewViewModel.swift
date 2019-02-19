//
//  CastAndCrewViewModel.swift
//  Challenge
//
//  Created by Nah on 2/20/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

typealias CastAndCrewViewModelDependency = CastAndCrewViewModel.Dependency
extension CastAndCrewViewModel {
    struct Dependency {
        let detail: MovieDetail
        let credits: MovieCredits
    }
}

class CastAndCrewViewModel {
    let detail: MovieDetail
    let people: [Person]

    init(_ dependency: Dependency) {
        let castPeople = dependency.credits.casts.map({ Person($0) })
        let crewPeople = dependency.credits.casts.map({ Person($0) })
        people = castPeople + crewPeople
        detail = dependency.detail
    }
}
