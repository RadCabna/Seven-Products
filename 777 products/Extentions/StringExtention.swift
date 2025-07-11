//
//  StringExtention.swift
//  777 products
//
//  Created by Алкександр Степанов on 11.07.2025.
//

import Foundation

extension String {
    
    /// Преобразует "18.01.25" в "January 18, 2025"
    func toEnglishDate() -> String {
        let formatter = Formatter()
        return formatter.convertToEnglishFormat(self)
    }
    
    /// Преобразует "January 18, 2025" в "18.01.25"
    func toShortDate() -> String {
        let formatter = Formatter()
        return formatter.convertToShortFormat(self)
    }
}
