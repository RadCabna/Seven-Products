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

extension Date {
    func toShortFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: self)
    }
}

// MARK: - Расширения для работы с числами
extension Double {
    
    /// Убирает лишние нули после запятой
    /// Пример: 1.0 -> "1", 1.5 -> "1.5", 1.50 -> "1.5"
    var cleanString: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    /// Форматирует число с указанным количеством знаков после запятой
    /// - Parameter places: Количество знаков после запятой
    /// - Returns: Отформатированная строка
    func formatted(places: Int) -> String {
        return String(format: "%.\(places)f", self)
    }
    
    /// Форматирует число как валюту без лишних нулей
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self)) ?? String(self)
    }
    
    /// Форматирует число с ровно 2 знаками после запятой
    /// Пример: 1.0 -> "1.00", 1.5 -> "1.50", 1.567 -> "1.57"
    var twoDecimalString: String {
        return String(format: "%.2f", self)
    }
    
    /// Форматирует число как валюту с ровно 2 знаками после запятой
    /// Пример: 1.0 -> "$1.00", 1.5 -> "$1.50"
    var currencyTwoDecimalString: String {
        return "$\(self.twoDecimalString)"
    }
    
    /// Форматирует число как валюту с символом доллара
    var dollarString: String {
        return "$\(self.currencyString)"
    }
    
    /// Проверяет, является ли число целым
    var isInteger: Bool {
        return self.truncatingRemainder(dividingBy: 1) == 0
    }
    
    /// Возвращает целую часть числа
    var integerPart: Int {
        return Int(self)
    }
    
    /// Возвращает дробную часть числа
    var fractionalPart: Double {
        return self.truncatingRemainder(dividingBy: 1)
    }
}

extension Int {
    /// Конвертирует Int в Double
    var asDouble: Double {
        return Double(self)
    }
}

extension String {
    /// Конвертирует строку в Double, возвращает 0 если не удалось
    var asDouble: Double {
        return Double(self) ?? 0
    }
    
    /// Конвертирует строку в Int, возвращает 0 если не удалось
    var asInt: Int {
        return Int(self) ?? 0
    }
}

// MARK: - Примеры использования
extension Double {
    static func examples() {
        let numbers: [Double] = [1.0, 1.5, 1.50, 2.0, 2.25, 3.0, 0.0, 10.0]
        
        print("=== Примеры форматирования Double ===")
        for number in numbers {
            print("\(number) -> cleanString: '\(number.cleanString)'")
            print("\(number) -> currencyString: '\(number.currencyString)'")
            print("\(number) -> dollarString: '\(number.dollarString)'")
            print("\(number) -> isInteger: \(number.isInteger)")
            print("---")
        }
    }
}
