//
//  MovieAPI.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Alamofire
import Foundation

enum MovieAPI {
    case getTopRatedMovies(page: Int)
    case getNowPlayingMovies(page: Int)
    case getDetailMovie(id: Int)

    private enum Const {
        static let BaseURLPath = "https://api.themoviedb.org/3"
        static let Key = "31b9e98ad4dcd29fa0cd622b3efc4d1b"
    }
}

extension MovieAPI: APIEndpoint {
    var baseURLPath: String {
        return Const.BaseURLPath
    }

    var path: String {
        switch self {
        case .getTopRatedMovies:
            return "/movie/top_rated"
        case .getNowPlayingMovies:
            return "/movie/now_playing"
        case let .getDetailMovie(id):
            return "/movie/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTopRatedMovies,
             .getNowPlayingMovies,
             .getDetailMovie:
            return .get
        }
    }

    var parameters: Parameters? {
        var params: Parameters = ["api_key": Const.Key]
        switch self {
        case let .getNowPlayingMovies(page),
             let .getTopRatedMovies(page):
            params["page"] = page
        default:
            break
        }
        return params
    }

    var parameterEncoding: ParameterEncoding? {
        return nil
    }

    var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        switch self {
        case .getTopRatedMovies,
             .getNowPlayingMovies,
             .getDetailMovie:
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
        }

        return decoder
    }
}
