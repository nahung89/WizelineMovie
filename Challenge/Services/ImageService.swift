//
//  ImageService.swift
//  Challenge
//
//  Created by Nah on 2/19/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import Kingfisher
import RxSwift
import UIKit

extension ImageService {
    enum Kind {
        case backdrop, poster, profile
    }
}

class ImageService {
    static let shared = ImageService()

    private let repository = ImageConfigurationRepository()
    private var configurationImage: Configuration.Image
    private var disposeBag = DisposeBag()

    private init() {
        configurationImage = repository.configurationImage

        repository.apiState.asObservable()
            .filter({ $0.isResponse })
            .subscribe(onNext: { [unowned self] _ in
                guard let configuration = self.repository.configurationImage else { return }
                self.configurationImage = configuration
            }).disposed(by: disposeBag)

        repository.refresh()
    }

    func combine(_ imagePath: String, kind: Kind, size: CGSize) -> URL? {
        return url(kind: kind, size: size).appendingPathComponent(imagePath)
    }
}

private extension ImageService {
    func url(kind: Kind, size: CGSize) -> URL {
        var preferSize = ImageConst.Size

        switch kind {
        case .backdrop:
            preferSize = findSuitable(viewSize: size, in: configurationImage.backdropSizes)
        case .poster:
            preferSize = findSuitable(viewSize: size, in: configurationImage.posterSizes)
        case .profile:
            preferSize = findSuitable(viewSize: size, in: configurationImage.posterSizes)
        }

        return configurationImage.baseUrl.appendingPathComponent(preferSize)
    }

    func findSuitable(viewSize: CGSize, in serverImageSizes: [String]) -> String {
        guard !serverImageSizes.isEmpty else { return ImageConst.Size }

        let viewWidth = Float(viewSize.width * UIScreen.main.scale)
        let viewHeight = Float(viewSize.height * UIScreen.main.scale)

        for serverImageSize in serverImageSizes {
            let widthStr = serverImageSize.replacingOccurrences(of: "w", with: "")
            if let width = Float(widthStr), width > viewWidth {
                return serverImageSize
            }

            let heightStr = serverImageSize.replacingOccurrences(of: "h", with: "")
            if let height = Float(heightStr), height > viewHeight {
                return serverImageSize
            }
        }

        return serverImageSizes.last!
    }
}

extension UIImageView {
    func loadOrEmpty(_ path: String?, kind: ImageService.Kind) {
        guard let path = path else {
            image = nil
            return
        }

        let url = ImageService.shared.combine(path, kind: kind, size: bounds.size)
        kf.setImage(with: url, placeholder: Asset.placeholder.image)
    }
}
