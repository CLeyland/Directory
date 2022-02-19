//
//  Debounced.swift
//  Directory
//
//  Created by Chris on 12/02/2022.
//

import Foundation

/// Fires the ``on(action: @escaping (T) -> Void)`` handler after the specified delay
/// if no new value has been received
@propertyWrapper
public class Debounced<T> {
    private var value: T?
    private var action: (T) -> Void = { _ in }

    private var delay: TimeInterval
    private var queue: DispatchQueue
    private var dispatchWorkItem: DispatchWorkItem = DispatchWorkItem {}

    /// Adds a Debounced action to the property after the given delay
    /// - Parameters:
    ///   - delay: The time interval to wait before the given action shoud be
    ///            executed if no new vakue is received
    ///   - queue: The dispatchQeue used to run the action
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

    /// Provides an action block to execute after the delay has elapsed
    /// - Parameter action: The action to execute
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
