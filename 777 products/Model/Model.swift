//
//  Model.swift
//  777 products
//
//  Created by Алкександр Степанов on 09.07.2025.
//

import Foundation

struct BarButton {
    var name: String
    var text: String
}

struct Product {
    var image: String
    var title: String
    var amount: String
    var price: String
}

struct Category {
    var image: String
    var name: String
}

struct ListItemOffset {
    var offset: CGFloat = 0
    var moved: Bool = false
}

class Arrays {
    
    static var categoriesArray: [Category] = [
        Category(image: "productImage1", name: "Fruit"),
        Category(image: "productImage2", name: "Vegetables"),
        Category(image: "productImage3", name: "Meat"),
        Category(image: "productImage4", name: "Dairy"),
        Category(image: "productImage5", name: "Beverages"),
        Category(image: "productImage6", name: "Berries"),
        Category(image: "productImage7", name: "Oils"),
        Category(image: "productImage8", name: "Baths"),
        Category(image: "productImage9", name: "Sweets"),
        Category(image: "productImage10", name: "Nuts"),
        Category(image: "productImage11", name: "Household"),
        Category(image: "productImage12", name: "Bread and \npastries"),
    ]
    
    static var startTemplatesArray = [
        ["01.01.25","productImage1", "Apple", "1", "kg", "1.20"],
        ["01.01.25","productImage2", "Carrot", "1", "kg", "1.90"],
        ["01.01.25","productImage3", "Chicken breast", "1", "kg", "1.20"],
        ["01.01.25","productImage4", "Milk", "1", "l", "2.20"],
        ["01.01.25","productImage5", "Orange juice", "1", "l", "1.65"],
        ["01.01.25","productImage6", "Strawberries", "1", "kg", "4.20"],
        ["01.01.25","productImage7", "Olive oil", "0.5", "l", "7.20"],
        ["01.01.25","productImage8", "Shower gel", "0.25", "l", "4.10"],
        ["01.01.25","productImage9", "Chocolate bar", "1", "p", "1.50"],
        ["01.01.25","productImage10", "Almonds", "1", "kg", "8.20"],
        ["01.01.25","productImage11", "Apple", "1", "kg", "1.20"],
        ["01.01.25","productImage12", "Apple", "1", "kg", "1.20"]
    ]
    
    static var barButtons = [
        BarButton(name: "botBarHome", text: "Home"),
        BarButton(name: "botBarList", text: "List"),
        BarButton(name: "botBarStatistic", text: "Statictic"),
        BarButton(name: "botBarSettings", text: "Settings")
    ]
    
    static var settingsBGArray = ["setBG1","setBG2","setBG3","setBG4",]
}

//["botBarHome", "botBarList", "botBarStatictic", "botBarSettings"]

class Formatter {
    
    // MARK: - Properties
    private let inputFormatter = Foundation.DateFormatter()
    private let outputFormatter = Foundation.DateFormatter()
    private let monthFormatter = Foundation.DateFormatter()
    private let weekdayFormatter = Foundation.DateFormatter()
    
    init() {
        // Настройка для входящего формата "dd.MM.yy"
        inputFormatter.dateFormat = "dd.MM.yy"
        inputFormatter.locale = Locale(identifier: "en_US")
        
        // Настройка для исходящего формата "MMMM dd, yyyy"
        outputFormatter.dateFormat = "MMMM dd, yyyy"
        outputFormatter.locale = Locale(identifier: "en_US")
        
        // Настройка для получения месяца из 3 букв
        monthFormatter.dateFormat = "MMM"
        monthFormatter.locale = Locale(identifier: "en_US")
        
        // Настройка для получения дня недели из 3 букв
        weekdayFormatter.dateFormat = "EEE"
        weekdayFormatter.locale = Locale(identifier: "en_US")
    }
    
    // MARK: - Methods
    
    /// Преобразует "18.01.25" в "January 18, 2025"
    func convertToEnglishFormat(_ dateString: String) -> String {
        guard let date = inputFormatter.date(from: dateString) else {
            return dateString // Возвращаем исходную строку, если не удалось распарсить
        }
        return outputFormatter.string(from: date)
    }
    
    /// Преобразует "January 18, 2025" в "18.01.25"
    func convertToShortFormat(_ dateString: String) -> String {
        // Временно меняем формат для парсинга английской даты
        let tempFormatter = Foundation.DateFormatter()
        tempFormatter.dateFormat = "MMMM dd, yyyy"
        tempFormatter.locale = Locale(identifier: "en_US")
        
        guard let date = tempFormatter.date(from: dateString) else {
            return dateString // Возвращаем исходную строку, если не удалось распарсить
        }
        
        return inputFormatter.string(from: date)
    }
    
    /// Получает месяц из 3 букв из даты в формате "dd.MM.yy"
    /// - Parameter dateString: Дата в формате "18.01.25"
    /// - Returns: Месяц в формате "JAN"
    func getMonthAbbreviation(_ dateString: String) -> String {
        guard let date = inputFormatter.date(from: dateString) else {
            return "ERR" // Возвращаем ошибку, если не удалось распарсить
        }
        return monthFormatter.string(from: date).uppercased()
    }
    
    /// Получает день недели из 3 букв из даты в формате "dd.MM.yy"
    /// - Parameter dateString: Дата в формате "18.01.25"
    /// - Returns: День недели в формате "SAT"
    func getWeekdayAbbreviation(_ dateString: String) -> String {
        guard let date = inputFormatter.date(from: dateString) else {
            return "ERR" // Возвращаем ошибку, если не удалось распарсить
        }
        return weekdayFormatter.string(from: date).uppercased()
    }
    
    /// Получает месяц из 3 букв из любой даты
    /// - Parameter dateString: Дата в любом формате
    /// - Returns: Месяц в формате "JAN"
    func getMonthFromAnyDate(_ dateString: String) -> String {
        // Пробуем разные форматы
        let formatters = [
            "dd.MM.yy",
            "dd.MM.yyyy",
            "MM/dd/yy",
            "MM/dd/yyyy",
            "yyyy-MM-dd"
        ]
        
        for format in formatters {
            let tempFormatter = Foundation.DateFormatter()
            tempFormatter.dateFormat = format
            tempFormatter.locale = Locale(identifier: "en_US")
            
            if let date = tempFormatter.date(from: dateString) {
                return monthFormatter.string(from: date).uppercased()
            }
        }
        
        return "ERR"
    }
    
    /// Получает день недели из 3 букв из любой даты
    /// - Parameter dateString: Дата в любом формате
    /// - Returns: День недели в формате "SAT"
    func getWeekdayFromAnyDate(_ dateString: String) -> String {
        // Пробуем разные форматы
        let formatters = [
            "dd.MM.yy",
            "dd.MM.yyyy",
            "MM/dd/yy",
            "MM/dd/yyyy",
            "yyyy-MM-dd"
        ]
        
        for format in formatters {
            let tempFormatter = Foundation.DateFormatter()
            tempFormatter.dateFormat = format
            tempFormatter.locale = Locale(identifier: "en_US")
            
            if let date = tempFormatter.date(from: dateString) {
                return weekdayFormatter.string(from: date).uppercased()
            }
        }
        
        return "ERR"
    }
}
