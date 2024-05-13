//
//  Strings+RAM.swift
//  RickAndMortyApp
//
//  Created by Ton Silva on 13/5/24.
//

import Foundation

// MARK: - Localizable
protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension Localizable {
    // Function to get localized string for a given key
    func localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
