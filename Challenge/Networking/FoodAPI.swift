//
//  FoodAPI.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Alamofire
import Foundation

enum FoodAPI {
    case getRecipes

    private enum Const {
        static let BaseURLPath = "https://food2fork.com/api"
        static let Key = "f1c105dd473738d96661a5a644ba4815"
    }
}

extension FoodAPI: APIEndpoint {
    var baseURLPath: String {
        return Const.BaseURLPath
    }

    var path: String {
        switch self {
        case .getRecipes:
            return "search"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getRecipes:
            return .get
        }
    }

    var parameters: Parameters? {
        let params: Parameters = ["key": Const.Key]
        switch self {
        case .getRecipes:
            break
        }
        return params
    }

    var parameterEncoding: ParameterEncoding? {
        return nil
    }
}
