//
//  Appearance.swift
//  Soccer
//
//  Created by Andrey Chernyshev on 23.04.2021.
//

import UIKit

struct Appearance {
    static let mono100 = UIColor.white
    static let mono200 = UIColor(integralRed: 1, green: 1, blue: 1)
    static let main100 = UIColor(integralRed: 227, green: 227, blue: 227)
    static let main200 = UIColor(integralRed: 108, green: 189, blue: 217)
    static let main300 = UIColor(integralRed: 178, green: 235, blue: 255)
    static let main400 = UIColor(integralRed: 45, green: 200, blue: 146)
    static let main500 = UIColor(integralRed: 174, green: 64, blue: 255)
    static let main600 = UIColor(integralRed: 245, green: 221, blue: 0)
    static let main700 = UIColor(integralRed: 247, green: 247, blue: 247)
    static let system100 = UIColor(integralRed: 235, green: 96, blue: 105)
    static let gradientColors = [
        Appearance.main700.withAlphaComponent(0).cgColor,
        Appearance.main700.withAlphaComponent(0.66).cgColor
    ]
    static let custom_171C10 = UIColor(integralRed: 23, green: 28, blue: 16)
}
