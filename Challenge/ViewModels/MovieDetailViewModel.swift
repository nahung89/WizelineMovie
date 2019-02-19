//
//  MovieDetailViewModel.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import RxSwift

typealias MovieDetailViewModelDependency = MovieDetailViewModel.Dependency
extension MovieDetailViewModel {
    struct Dependency {
        let repository: MovieDetailRepository
    }
}

class MovieDetailViewModel {
    let viewState: BehaviorSubject<ViewState> = BehaviorSubject(value: .blank)
    let onRefresh: PublishSubject<Void> = PublishSubject()

    private(set) var movieDetail: MovieDetail

    private let repository: MovieDetailRepository
    private let disposeBag = DisposeBag()

    init(_ dependency: Dependency) {
        repository = dependency.repository
        movieDetail = repository.movieDetail

        onRefresh.subscribe(onNext: { [unowned self] _ in
            self.refresh()
        }).disposed(by: disposeBag)

        repository.apiState.asObservable()
            .map({ ViewState($0) })
            .do(onNext: { [unowned self] viewState in
                guard viewState == .working else { return }
                self.movieDetail = self.repository.movieDetail
            })
            .bind(to: viewState)
            .disposed(by: disposeBag)
    }

    func refresh() {
        repository.fetch()
    }
}
