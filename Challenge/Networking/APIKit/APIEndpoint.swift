//
//  APIRouter.swift
//  Data
//
//  Created by Nah on 2/16/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift

protocol APIEndpoint: URLRequestConvertible {
    var baseURLPath: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding? { get }

    func response<T: Decodable>(_ type: T.Type) -> Observable<T>
}

extension APIEndpoint {
    var headers: HTTPHeaders {
        return ["Accept": "application/json"]
    }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURLPath.asURL().appendingPathComponent(path)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 10 * 1000
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        switch method {
        case .post:
            if let params = parameters {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
            return urlRequest
        default:
            let encoding = parameterEncoding ?? URLEncoding.default
            return try encoding.encode(urlRequest, with: parameters)
        }
    }

    func response<T: Decodable>(_ type: T.Type) -> Observable<T> {
        return Alamofire.request(self)
            .validate()
            .rx.responseEntity(type)
    }
}
