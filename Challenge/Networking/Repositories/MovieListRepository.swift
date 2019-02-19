//
//  ListMovieRepository.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import RxSwift

class MovieListRepository {
    let apiState: BehaviorSubject<APIState> = BehaviorSubject(value: .stop)

    private var movieList: MovieList?
    private(set) var movies: [Movie] = []

    private var request: Disposable?
    private let disposeBag = DisposeBag()

    func fetch() {
        request?.dispose()
        apiState.onNext(.request)

        request = MovieAPI.getTopRatedMovies
            .response(MovieList.self)
            .subscribe(onNext: { [unowned self] result in
                self.bind(result)
                self.apiState.onNext(.response)
            }, onError: { [unowned self] error in
                self.apiState.onNext(.fail(error))
            })

        request?.disposed(by: disposeBag)
    }

    private func bind(_ result: MovieList) {
        movieList = result
        movies.append(contentsOf: result.movies)
    }
}
