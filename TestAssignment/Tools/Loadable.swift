//
//  Loadable.swift
//  TestAssignment
//
//  Created by Alexey Naumov on 19/07/2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import Foundation

enum Loadable<Value> {
    case notRequested
    case isLoading(prevValue: Value?)
    case loaded(Value)
    case failed(error: Error?, prevValue: Value?)
}

extension Loadable {
    var value: Value? {
        switch self {
        case .notRequested: return nil
        case let .loaded(value): return value
        case let .isLoading(value), let .failed(_, value): return value
        }
    }
    var error: Error? {
        switch self {
        case let .failed(error, _): return error
        default: return nil
        }
    }
    var isLoading: Bool {
        switch self {
        case .isLoading: return true
        default: return false
        }
    }
    var isLoaded: Bool {
        switch self {
        case .loaded: return true
        default: return false
        }
    }
    var isFailed: Bool {
        switch self {
        case .failed: return true
        default: return false
        }
    }
}
