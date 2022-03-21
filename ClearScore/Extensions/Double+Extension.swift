//
//  Double+Extension.swift
//  ClearScore
//
//  Created by Alex McPherson on 13/03/2022.
//

import Foundation

extension Double {
    func valueToPercentage(_ currentValue: Self, maxValue: Self) -> Self {
       return currentValue / maxValue * 100
    }

    func percentageToDegress(_ percentage: Self) -> Self {
        return percentage * 360 / 100
    }

    func degreesToRadians(_ number: Self) -> Self {
        return number * .pi / 180
    }
}
