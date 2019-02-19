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
    let apiState: Variable<APIState> = Variable(.stop)
    let type: MovieList.DataType

    private var movieList: MovieList?
    private(set) var movies: [Movie] = []

    private var currentPage: Int = 0
    private var request: Disposable?
    private let disposeBag = DisposeBag()

    init(dataType: MovieList.DataType) {
        type = dataType
    }

    func refresh() {
        clear()
        fetch()
    }

    func fetchNext() {
        guard !apiState.value.isRequest else { return }
        fetch()
    }
}

private extension MovieListRepository {
    func clear() {
        currentPage = 0
        movies = []
        apiState.value = .stop
    }

    func fetch() {
        guard let api = makeAPI() else { return }

        request?.dispose()
        apiState.value = .request

        request = api
            .response(MovieList.self)
            .subscribe(onNext: { [unowned self] result in
                self.bind(result)
                self.apiState.value = .response
            }, onError: { [unowned self] error in
                self.apiState.value = .fail(error)
            })

        request?.disposed(by: disposeBag)
    }

    func bind(_ result: MovieList) {
        movieList = result
        currentPage = result.page
        movies.append(contentsOf: result.movies)
    }

    func makeAPI() -> MovieAPI? {
        let maxPage = movieList?.totalPages ?? Int.max

        guard currentPage < maxPage else { return nil }

        let nextPage = currentPage + 1
        switch type {
        case .nowPlaying:
            return .getNowPlayingMovies(page: nextPage)
        case .topRate:
            return .getTopRatedMovies(page: nextPage)
        }
    }
}
