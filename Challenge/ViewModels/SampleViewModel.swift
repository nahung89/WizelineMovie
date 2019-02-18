//
//  RecipeListViewModel.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Alamofire
import Foundation
import RxSwift

typealias SampleViewModelDependency = SampleViewModel.Dependency
extension SampleViewModel {
    struct Dependency {
        let repository: SampleRepository
    }
}

class SampleViewModel {
    let viewState: BehaviorSubject<ViewState> = BehaviorSubject(value: .blank)
    let onRefresh: PublishSubject<Void?> = PublishSubject()

    private(set) var recipes: [Recipe] = []

    private let repository: SampleRepository
    private let disposeBag = DisposeBag()

    init(_ dependency: Dependency) {
        repository = dependency.repository

        onRefresh.subscribe(onNext: { [unowned self] _ in
            self.repository.fetch()
        }).disposed(by: disposeBag)

        repository.apiState
            .map({ ViewState($0) })
            .do(onNext: { [unowned self] viewState in
                guard viewState == .working else { return }
                self.recipes = self.repository.recipes
            })
            .bind(to: viewState)
            .disposed(by: disposeBag)
    }

    func refresh() {
        repository.fetch()
    }
}
