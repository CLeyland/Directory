//
//  Debounced.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation

@propertyWrapper
public class Debounced<T> {
    private var value: T?
    private var action: (T) -> Void = { _ in }

    private var delay: TimeInterval
    private var queue: DispatchQueue
    private var dispatchWorkItem: DispatchWorkItem = DispatchWorkItem {}

    public init(_ delay: TimeInterval, on queue: DispatchQueue = .main) {
        self.delay = delay
        self.queue = queue
    }

    public var wrappedValue: T? {
        get { value }
        set {
            if let newValue = newValue {
                value = newValue
                dispatch()
            } else {
                value = nil
                dispatchWorkItem.cancel()
            }
        }
    }

    public func on(action: @escaping (T) -> Void) {
        self.action = action
    }

    private func dispatch() {
        dispatchWorkItem.cancel()
        dispatchWorkItem = DispatchWorkItem {
            [weak self] in

            if let value = self?.value {
                self?.action(value)
            }
        }

        queue.asyncAfter(deadline: .now() + delay, execute: dispatchWorkItem)
    }
}
