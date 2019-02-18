//
//  SessionManager+Ext.swift
//  Data
//
//  Created by Nah on 2/16/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift

extension SessionManager: ReactiveCompatible {}

extension Reactive where Base: SessionManager {
    func encodeMultipartUpload(with url: URLRequestConvertible,
                               data: @escaping (MultipartFormData) -> Void) -> Observable<UploadRequest> {
        return Observable.create { observer in
            self.base.upload(multipartFormData: data,
                             with: url,
                             encodingCompletion: { encodingResult in
                                 switch encodingResult {
                                 case let .failure(error):
                                     observer.onError(error)
                                 case .success(let request, _, _):
                                     observer.onNext(request)
                                     observer.onCompleted()
                                 }
            })

            return Disposables.create()
        }
    }
}
