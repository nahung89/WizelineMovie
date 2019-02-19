//
//  MovieDetailRepository.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import RxSwift

class MovieDetailRepository {
    let apiState: Variable<APIState> = Variable(.stop)

    private(set) var movieDetail: MovieDetail

    private var request: Disposable?
    private let disposeBag = DisposeBag()

    init(movie: Movie) {
        self.movieDetail = MovieDetail(movie: movie)
    }

    func fetch() {
        request?.dispose()
        apiState.value = .request

        request = MovieAPI.getDetailMovie(id: movieDetail.id)
            .response(MovieDetail.self)
            .subscribe(onNext: { [unowned self] result in
                self.movieDetail = result
                self.apiState.value = .response
            }, onError: { [unowned self] error in
                self.apiState.value = .fail(error)
            })

        request?.disposed(by: disposeBag)
    }
}
