//
//  SampleRepository.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import RxSwift

class SampleRepository {
    let apiState: BehaviorSubject<APIState> = BehaviorSubject(value: .stop)

    private(set) var recipes: [Recipe] = []

    private var request: Disposable?
    private let disposeBag = DisposeBag()

    func fetch() {
        request?.dispose()
        apiState.onNext(.request)

        request = FoodAPI.getRecipes
            .response(Recipes.self)
            .subscribe(onNext: { [unowned self] result in
                self.recipes = result.recipes
                self.apiState.onNext(.response)
            }, onError: { [unowned self] error in
                self.apiState.onNext(.fail(error))
            })

        request?.disposed(by: disposeBag)
    }
}
