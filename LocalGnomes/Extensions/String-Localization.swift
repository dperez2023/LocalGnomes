//
//  String+Localization.swift
//  LocalGnomes
//
//  Created by dperezserrano on 24/5/22.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, bundle: Bundle.main, comment: "")
    }
}
