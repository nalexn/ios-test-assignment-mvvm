//
//  Property.swift
//  TestAssignment
//
//  Created by Alexey Naumov on 19/07/2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import Signals

// MARK: - Property

/**
 **Property** wraps an arbitrary variable into an observable valiable.
 You still can get and set the underlying value, while all subscribers are notified when the value is changed
 It retains the last assigned value, which is always accessible with the getter
 */
struct Property<T> {

    private let signal: Signal<T>

    var value: T {
        get { return signal.lastDataFired! }
        set {
            assert(Thread.isMainThread, "Mutation must happen in main thread because UI code might be observing changes")
            signal.fire(newValue)
        }
    }

    init(value: T) {
        signal = Signal<T>(retainLastData: true)
        signal.fire(value)
    }

    func observe(whileAlive observer: AnyObject, callback: @escaping (T) -> Void) {
        signal.subscribePast(with: observer, callback: callback)
    }

    func remove(observer: AnyObject) {
        signal.cancelSubscription(for: observer)
    }
    
    func removeAllObservers() {
        signal.cancelAllSubscriptions()
    }
}
