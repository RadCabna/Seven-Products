import SwiftUI

struct DoubleFormattingExample: View {
    @State private var testNumber: Double = 1.50
    @State private var results: [String] = []
    
    let testNumbers: [Double] = [1.0, 1.5, 1.50, 2.0, 2.25, 3.0, 0.0, 10.0, 15.75, 100.0]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Форматирование Double")
                .font(.title)
                .fontWeight(.bold)
            
            // Поле ввода для тестирования
            VStack(alignment: .leading) {
                Text("Введите число для тестирования:")
                    .font(.headline)
                
                TextField("Например: 1.50", value: $testNumber, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .onChange(of: testNumber) { _ in
                        updateResults()
                    }
            }
            .padding()
            
            // Результаты для введенного числа
            VStack(alignment: .leading, spacing: 8) {
                Text("Результаты для \(testNumber):")
                    .font(.headline)
                
                ForEach(results, id: \.self) { result in
                    Text(result)
                        .font(.body)
                        .padding(.horizontal)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)
            
            // Примеры для всех тестовых чисел
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Примеры для разных чисел:")
                        .font(.headline)
                    
                    ForEach(testNumbers, id: \.self) { number in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(number):")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            HStack {
                                Text("cleanString:")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("'\(number.cleanString)'")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                            
                            HStack {
                                Text("twoDecimalString:")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("'\(number.twoDecimalString)'")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                            
                            HStack {
                                Text("currencyString:")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("'\(number.currencyString)'")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                            
                            HStack {
                                Text("dollarString:")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("'\(number.dollarString)'")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                            
                            HStack {
                                Text("isInteger:")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("\(number.isInteger ? "Да" : "Нет")")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                .padding()
            }
            
            // Кнопка для запуска примеров в консоли
            Button("Запустить примеры в консоли") {
                Double.examples()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {
            updateResults()
        }
    }
    
    private func updateResults() {
        results = [
            "cleanString: '\(testNumber.cleanString)'",
            "twoDecimalString: '\(testNumber.twoDecimalString)'",
            "currencyString: '\(testNumber.currencyString)'",
            "currencyTwoDecimalString: '\(testNumber.currencyTwoDecimalString)'",
            "dollarString: '\(testNumber.dollarString)'",
            "formatted(places: 2): '\(testNumber.formatted(places: 2))'",
            "formatted(places: 0): '\(testNumber.formatted(places: 0))'",
            "isInteger: \(testNumber.isInteger ? "Да" : "Нет")",
            "integerPart: \(testNumber.integerPart)",
            "fractionalPart: \(testNumber.fractionalPart)"
        ]
    }
}

// MARK: - Дополнительные примеры использования
struct DoubleUsageExamples {
    
    static func practicalExamples() {
        print("\n=== Практические примеры использования ===")
        
        // Примеры с ценами
        let prices: [Double] = [1.0, 1.50, 2.25, 10.0, 15.75, 100.0]
        
        print("Цены:")
        for price in prices {
            print("\(price) -> \(price.dollarString)")
        }
        
        // Примеры с процентами
        let percentages: [Double] = [25.0, 33.33, 50.0, 100.0]
        
        print("\nПроценты:")
        for percent in percentages {
            print("\(percent)% -> \(percent.cleanString)%")
        }
        
        // Примеры с количеством
        let quantities: [Double] = [1.0, 1.5, 2.0, 0.5, 10.0]
        
        print("\nКоличество:")
        for quantity in quantities {
            print("\(quantity) -> \(quantity.cleanString)")
        }
        
        // Примеры с форматированием
        let numbers: [Double] = [1.23456, 2.5, 3.0, 4.99]
        
        print("\nРазличное форматирование:")
        for number in numbers {
            print("\(number):")
            print("  - 0 знаков: \(number.formatted(places: 0))")
            print("  - 1 знак: \(number.formatted(places: 1))")
            print("  - 2 знака: \(number.formatted(places: 2))")
            print("  - cleanString: \(number.cleanString)")
        }
    }
}

#Preview {
    DoubleFormattingExample()
} 