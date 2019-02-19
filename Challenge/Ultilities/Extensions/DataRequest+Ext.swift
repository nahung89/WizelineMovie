//
//  Alamofire+Ext.swift
//  Data
//
//  Created by Nah on 2/16/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift

extension DataRequest: ReactiveCompatible {
    @discardableResult
    func responseEntity<T: Decodable>(type: T.Type, decoder: JSONDecoder, completionHandler: @escaping (Alamofire.DataResponse<T>) -> Void) -> Self {
        return response(queue: DispatchQueue.global(),
                        responseSerializer: EntityResponseSerializer<T>(decoder),
                        completionHandler: { response in
                            DispatchQueue.main.async {
                                completionHandler(response)
                            }
        })
    }
}

extension Reactive where Base: DataRequest {
    func responseEntity<T: Decodable>(_ type: T.Type, decoder: JSONDecoder) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = self.base.responseEntity(type: type, decoder: decoder, completionHandler: { response in
                logger?.verbose((response.response?.statusCode, response.request))

                switch response.result {
                case let .failure(error):
                    observer.onError(error)
                    logger?.error(error)

                case let .success(value):
                    observer.onNext(value)
                    observer.onCompleted()
                }
            })

            return Disposables.create {
                request.cancel()
            }
        }
    }
}

private struct EntityResponseSerializer<T: Decodable>: DataResponseSerializerProtocol {
    var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<T>

    init(_ decoder: JSONDecoder = JSONDecoder()) {
        serializeResponse = { _, response, data, error in
            let result = Request.serializeResponseData(response: response, data: data, error: error)
            switch result {
            case let .failure(error):
                return Result.failure(error)
            case let .success(data):
                return Result<T>(value: { try decoder.decode(T.self, from: data) })
            }
        }
    }
}
