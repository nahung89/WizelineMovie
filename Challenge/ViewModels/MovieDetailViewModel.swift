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
        let detailRepository: MovieDetailRepository
        let creditRepository: MovieCreditsRepository
    }
}

class MovieDetailViewModel {
    let viewState: BehaviorSubject<ViewState> = BehaviorSubject(value: .blank)
    let onRefresh: PublishSubject<Void> = PublishSubject()

    private(set) var movieDetail: MovieDetail {
        didSet {
            parseData()
        }
    }

    private(set) var movieCredits: MovieCredits {
        didSet {
            parseData()
        }
    }

    private(set) var sections: [MovieDetailViewController.Section] = []
    private(set) var rowsInSections: [MovieDetailViewController.Section: [MovieDetailViewController.Row]] = [:]

    private let detailRepository: MovieDetailRepository
    private let creditRepository: MovieCreditsRepository
    private let disposeBag = DisposeBag()

    init(_ dependency: Dependency) {
        detailRepository = dependency.detailRepository
        creditRepository = dependency.creditRepository
        movieDetail = detailRepository.movieDetail
        movieCredits = creditRepository.movieCredits

        onRefresh.subscribe(onNext: { [unowned self] _ in
            self.refresh()
        }).disposed(by: disposeBag)

        detailRepository.apiState.asObservable()
            .map({ ViewState($0) })
            .do(onNext: { [unowned self] viewState in
                guard viewState == .working else { return }
                self.movieDetail = self.detailRepository.movieDetail
            })
            .bind(to: viewState)
            .disposed(by: disposeBag)

        creditRepository.apiState.asObservable()
            .map({ ViewState($0) })
            .do(onNext: { [unowned self] viewState in
                guard viewState == .working else { return }
                self.movieCredits = self.creditRepository.movieCredits
            })
            .bind(to: viewState)
            .disposed(by: disposeBag)

        // 1st call since KVO doesn't work in initalize
        parseData()
    }

    func refresh() {
        detailRepository.fetch()
        creditRepository.fetch()
    }
}

private extension MovieDetailViewModel {
    func parseData() {
        var newSections: [MovieDetailViewController.Section] = [.detail]

        // Only append if has cast or at least 1 director
        if !movieCredits.casts.isEmpty || movieCredits.crews.contains(where: { $0.job.lowercased() == "director" }) {
            newSections.append(.credits)
        }

        var newRowsInSections: [MovieDetailViewController.Section: [MovieDetailViewController.Row]] = [:]

        for section in newSections {
            var rows: [MovieDetailViewController.Row] = []
            switch section {
            case .detail:
                rows.append(contentsOf: [.backdrop, .title])
                if !movieDetail.overview.isEmpty {
                    rows.append(.summary)
                }

            case .credits:
                if !movieCredits.casts.isEmpty {
                    rows.append(.casts)
                }
                if movieCredits.crews.contains(where: { $0.job.lowercased() == "director" }) {
                    rows.append(.director)
                }
            }
            newRowsInSections[section] = rows
        }

        sections = newSections
        rowsInSections = newRowsInSections
    }
}
