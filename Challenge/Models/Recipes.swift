//
//  Recipes.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

struct Recipes: Decodable {
    let count: Int
    let recipes: [Recipe]
}
