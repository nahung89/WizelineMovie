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

    private(set) var feeds: [Feed] = []

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
                self.feeds = self.parseData(self.repository.movies)
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

    func parseData(_ movies: [Movie]) -> [Feed] {
        var newFeeds = feeds

        var adIndex = newFeeds.lastIndex(where: { $0.isAd }) ?? 0
        if adIndex > 0 {
            adIndex = newFeeds.count - 1 - adIndex
        }

        for i in stride(from: 0, to: movies.count, by: 1) {
            if adIndex + i > 0, (adIndex + i) % 3 == 0 {
                let advertise = Advertise(name: "WIZELINE ADVERTISEMENT")
                newFeeds.append(.ad(advertise))
            }
            newFeeds.append(.movie(movies[i]))
        }

        return newFeeds
    }
}
