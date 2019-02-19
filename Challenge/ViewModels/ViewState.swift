//
//  ViewState.swift
//  Challenge
//
//  Created by Nah on 2/17/19.
//  Copyright © 2019 Nah. All rights reserved.
//

import Foundation

enum ViewState {
    case blank
    case loading
    case working
    case error(Error)

    var isBlank: Bool {
        switch self {
        case .blank: return true
        default: return false
        }
    }

    var isLoading: Bool {
        switch self {
        case .loading: return true
        default: return false
        }
    }

    var isWorking: Bool {
        switch self {
        case .working: return true
        default: return false
        }
    }

    var isError: Bool {
        switch self {
        case .error: return true
        default: return false
        }
    }

    init(_ apiState: APIState) {
        switch apiState {
        case .request:
            self = .loading
        case .stop:
            self = .blank
        case let .fail(error):
            self = .error(error)
        case .response:
            self = .working
        }
    }
}

extension ViewState: Equatable {
    public static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case let (.error(err1), .error(err2)):
            return err1.localizedDescription == err2.localizedDescription
        case (.blank, .blank),
             (.loading, .loading),
             (.working, .working):
            return true
        default:
            return false
        }
    }
}
