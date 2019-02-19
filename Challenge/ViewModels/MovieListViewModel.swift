//
//  MovieListViewModel.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import RxSwift

typealias MovieListViewModelDependency = MovieListViewModel.Dependency
extension MovieListViewModel {
    struct Dependency {
        let repository: MovieListRepository
    }
}

class MovieListViewModel {
    let viewState: BehaviorSubject<ViewState> = BehaviorSubject(value: .blank)
    let onRefresh: PublishSubject<Void> = PublishSubject()
    let onLoadMore: PublishSubject<Void> = PublishSubject()

    private(set) var movies: [Movie] = []

    private let repository: MovieListRepository
    private let disposeBag = DisposeBag()

    init(_ dependency: Dependency) {
        repository = dependency.repository

        onRefresh.subscribe(onNext: { [unowned self] _ in
            self.refresh()
        }).disposed(by: disposeBag)

        onLoadMore.subscribe(onNext: { [unowned self] _ in
            self.loadMore()
        }).disposed(by: disposeBag)

        repository.apiState.asObservable()
            .map({ ViewState($0) })
            .do(onNext: { [unowned self] viewState in
                guard viewState == .working else { return }
                self.movies = self.repository.movies
            })
            .bind(to: viewState)
            .disposed(by: disposeBag)
    }

    func refresh() {
        repository.refresh()
    }

    func loadMore() {
        repository.fetchNext()
    }
}
