//
//  ObservableObject.swift
//  ClearScore
//
//  Created by Alex McPherson on 09/03/2022.
//

import Foundation

final class ObservableObject<T> {

    // MARK: - Properties
    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    // MARK: - Init
    init(_ value: T) {
        self.value = value
    }

    // MARK: - Methods
    func bind(_ listener: @escaping(T) -> Void) {
        listener(value)
        self.listener = listener
    }
}
