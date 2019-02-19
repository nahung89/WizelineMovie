//
//  ImageConfigurationRepository.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import RxSwift

class ImageConfigurationRepository {
    let apiState: Variable<APIState> = Variable(.stop)

    private(set) var configurationImage: Configuration.Image!

    private var request: Disposable?
    private let disposeBag = DisposeBag()

    init() {
        if let result = fetchUserDefaults() {
            configurationImage = result
        } else if let result = fetchBundle() {
            configurationImage = result
        } else {
            configurationImage = fetchConst()
        }
        assert(configurationImage != nil, "configuration image doesn't exist")
    }

    func refresh() {
        request?.dispose()

        request = MovieAPI.getConfiguration
            .response(Configuration.self)
            .subscribe(onNext: { [unowned self] result in
                self.configurationImage = result.image
                self.apiState.value = .response
                self.save(result.image)
            }, onError: { [unowned self] error in
                self.apiState.value = .fail(error)
            })

        request?.disposed(by: disposeBag)
    }
}

private extension ImageConfigurationRepository {
    func fetchConst() -> Configuration.Image {
        return Configuration.Image(baseUrl: URL(string: ImageConst.Scheme)!,
                                   backdropSizes: [ImageConst.Size],
                                   posterSizes: [ImageConst.Size],
                                   profileSizes: [ImageConst.Size])
    }

    func fetchUserDefaults() -> Configuration.Image? {
        guard let data = UserDefaults.standard.data(forKey: ImageConst.UserDefaultKey) else { return nil }

        do {
            return try JSONDecoder().decode(Configuration.Image.self, from: data)
        } catch {
            logger?.warning(error)
            return nil
        }
    }

    func fetchBundle() -> Configuration.Image? {
        guard let url = Bundle.main.url(forResource: ImageConst.Setting, withExtension: nil) else { return nil }

        do {
            let data = try Data(contentsOf: url)
            let configuration = try JSONDecoder().decode(Configuration.self, from: data)
            return configuration.image
        } catch {
            logger?.warning(error)
            return nil
        }
    }

    func save(_ object: Configuration.Image) {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: ImageConst.UserDefaultKey)
        } catch {
            logger?.warning(error)
        }
    }
}
