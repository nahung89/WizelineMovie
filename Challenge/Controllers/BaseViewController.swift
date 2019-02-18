//
//  BaseViewController.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        logger?.verbose(typeName)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        logger?.verbose(typeName)
    }

    deinit {
        logger?.verbose(typeName)
    }
}
