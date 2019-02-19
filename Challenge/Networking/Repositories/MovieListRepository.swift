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

    private(set) var movies: [Movie] = []

    private var totalPage: Int = .max
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
        totalPage = .max
        movies = []
        apiState.value = .stop
        request?.dispose()
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
        currentPage = result.page
        totalPage = result.totalPages
        movies.append(contentsOf: result.movies)
    }

    func makeAPI() -> MovieAPI? {
        guard currentPage < totalPage else { return nil }

        let nextPage = currentPage + 1
        switch type {
        case .nowPlaying:
            return .getNowPlayingMovies(page: nextPage)
        case .topRate:
            return .getTopRatedMovies(page: nextPage)
        }
    }
}
