//
//  APIState.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

enum APIState {
    case stop
    case request
    case response
    case fail(Error)

    var isStop: Bool {
        switch self {
        case .stop: return true
        default: return false
        }
    }

    var isRequest: Bool {
        switch self {
        case .request: return true
        default: return false
        }
    }

    var isResponse: Bool {
        switch self {
        case .response: return true
        default: return false
        }
    }

    var isFail: Bool {
        switch self {
        case .fail: return true
        default: return false
        }
    }
}
