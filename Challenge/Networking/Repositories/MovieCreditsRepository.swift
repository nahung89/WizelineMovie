//
//  MovieCreditsRepository.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import RxSwift

class MovieCreditsRepository {
    let apiState: Variable<APIState> = Variable(.stop)
    private(set) var movieCredits: MovieCredits

    private var request: Disposable?
    private let disposeBag = DisposeBag()

    init(movieId: Int) {
        movieCredits = MovieCredits(id: movieId, casts: [], crews: [])
    }

    func fetch() {
        request?.dispose()
        apiState.value = .request

        request = MovieAPI.getMovieCredits(movieId: movieCredits.id)
            .response(MovieCredits.self)
            .subscribe(onNext: { [unowned self] result in
                self.movieCredits = result
                self.apiState.value = .response
            }, onError: { [unowned self] error in
                self.apiState.value = .fail(error)
            })

        request?.disposed(by: disposeBag)
    }
}
