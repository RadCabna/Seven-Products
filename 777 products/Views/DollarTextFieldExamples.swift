import SwiftUI

struct DollarTextFieldExamples: View {
    @State private var amount1 = ""
    @State private var amount2 = ""
    @State private var amount3 = ""
    @State private var amount4 = ""
    @State private var amount5 = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                // 1. Простой способ - добавление $ в onChange
                VStack(alignment: .leading, spacing: 10) {
                    Text("1. Автоматическое добавление $")
                        .font(.headline)
                    
                    TextField("Введите сумму", text: $amount1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .onChange(of: amount1) { newValue in
                            // Убираем все символы кроме цифр и точки
                            let cleaned = newValue.filter { $0.isNumber || $0 == "." }
                            
                            // Добавляем $ в начало, если его нет
                            if !cleaned.isEmpty && !cleaned.hasPrefix("$") {
                                amount1 = "$" + cleaned
                            } else if cleaned.isEmpty {
                                amount1 = ""
                            } else {
                                amount1 = cleaned.hasPrefix("$") ? cleaned : "$" + cleaned
                            }
                        }
                        .padding(.horizontal)
                    
                    Text("Результат: \(amount1)")
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // 2. С форматированием числа
                VStack(alignment: .leading, spacing: 10) {
                    Text("2. Форматирование с разделителями")
                        .font(.headline)
                    
                    TextField("Введите сумму", text: $amount2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .onChange(of: amount2) { newValue in
                            amount2 = formatCurrency(newValue)
                        }
                        .padding(.horizontal)
                    
                    Text("Результат: \(amount2)")
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // 3. С плейсхолдером, содержащим $
                VStack(alignment: .leading, spacing: 10) {
                    Text("3. Плейсхолдер с $")
                        .font(.headline)
                    
                    TextField("$0.00", text: $amount3)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .onChange(of: amount3) { newValue in
                            let cleaned = newValue.filter { $0.isNumber || $0 == "." }
                            if !cleaned.isEmpty {
                                amount3 = "$" + cleaned
                            } else {
                                amount3 = ""
                            }
                        }
                        .padding(.horizontal)
                }
                
                Divider()
                
                // 4. С кастомным стилем и иконкой
                VStack(alignment: .leading, spacing: 10) {
                    Text("4. Кастомный стиль с иконкой")
                        .font(.headline)
                    
                    HStack {
                        Text("$")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        
                        TextField("0.00", text: $amount4)
                            .textFieldStyle(PlainTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .onChange(of: amount4) { newValue in
                                // Убираем все кроме цифр и точки
                                amount4 = newValue.filter { $0.isNumber || $0 == "." }
                            }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.green.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 2)
                            )
                    )
                    .padding(.horizontal)
                    
                    Text("Сумма: $\(amount4)")
                        .foregroundColor(.green)
                        .fontWeight(.semibold)
                }
                
                Divider()
                
                // 5. С валидацией и ограничениями
                VStack(alignment: .leading, spacing: 10) {
                    Text("5. Валидация и ограничения")
                        .font(.headline)
                    
                    TextField("Введите сумму", text: $amount5)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .onChange(of: amount5) { newValue in
                            amount5 = validateAndFormatCurrency(newValue)
                        }
                        .padding(.horizontal)
                    
                    if !amount5.isEmpty {
                        HStack {
                            Image(systemName: isValidAmount(amount5) ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .foregroundColor(isValidAmount(amount5) ? .green : .red)
                            
                            Text(isValidAmount(amount5) ? "Валидная сумма" : "Невалидная сумма")
                                .foregroundColor(isValidAmount(amount5) ? .green : .red)
                        }
                    }
                }
                
                Divider()
                
                // 6. С NumberFormatter
                VStack(alignment: .leading, spacing: 10) {
                    Text("6. Использование NumberFormatter")
                        .font(.headline)
                    
                    TextField("Введите сумму", text: $amount5)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .onChange(of: amount5) { newValue in
                            amount5 = formatWithNumberFormatter(newValue)
                        }
                        .padding(.horizontal)
                }
            }
            .padding()
        }
    }
    
    // Функция форматирования валюты с разделителями
    private func formatCurrency(_ input: String) -> String {
        // Убираем все кроме цифр
        let cleaned = input.filter { $0.isNumber }
        
        if cleaned.isEmpty {
            return ""
        }
        
        // Преобразуем в число
        if let number = Double(cleaned) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$"
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            
            return formatter.string(from: NSNumber(value: number)) ?? "$\(number)"
        }
        
        return "$\(cleaned)"
    }
    
    // Функция валидации и форматирования
    private func validateAndFormatCurrency(_ input: String) -> String {
        // Убираем $ если есть
        var cleaned = input.replacingOccurrences(of: "$", with: "")
        
        // Убираем все кроме цифр и точки
        cleaned = cleaned.filter { $0.isNumber || $0 == "." }
        
        // Проверяем, что точка только одна
        let dots = cleaned.filter { $0 == "." }
        if dots.count > 1 {
            // Оставляем только первую точку
            let components = cleaned.components(separatedBy: ".")
            if components.count > 1 {
                cleaned = components[0] + "." + components.dropFirst().joined()
            }
        }
        
        // Ограничиваем количество знаков после точки
        if let dotIndex = cleaned.firstIndex(of: ".") {
            let afterDot = cleaned[cleaned.index(after: dotIndex)...]
            if afterDot.count > 2 {
                cleaned = String(cleaned.prefix(through: cleaned.index(dotIndex, offsetBy: 2)))
            }
        }
        
        // Добавляем $ если есть число
        if !cleaned.isEmpty {
            return "$" + cleaned
        }
        
        return ""
    }
    
    // Функция валидации суммы
    private func isValidAmount(_ amount: String) -> Bool {
        let cleaned = amount.replacingOccurrences(of: "$", with: "")
        guard let number = Double(cleaned) else { return false }
        return number > 0 && number <= 999999.99
    }
    
    // Функция с NumberFormatter
    private func formatWithNumberFormatter(_ input: String) -> String {
        let cleaned = input.filter { $0.isNumber || $0 == "." }
        
        if cleaned.isEmpty {
            return ""
        }
        
        if let number = Double(cleaned) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$"
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            formatter.groupingSeparator = ","
            formatter.groupingSize = 3
            
            return formatter.string(from: NSNumber(value: number)) ?? "$\(number)"
        }
        
        return "$\(cleaned)"
    }
}

// Кастомный TextField с автоматическим $
struct DollarTextField: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        HStack {
            Text("$")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .keyboardType(.decimalPad)
                .onChange(of: text) { newValue in
                    // Убираем все кроме цифр и точки
                    let cleaned = newValue.filter { $0.isNumber || $0 == "." }
                    
                    // Ограничиваем количество знаков после точки
                    var result = cleaned
                    if let dotIndex = cleaned.firstIndex(of: ".") {
                        let afterDot = cleaned[cleaned.index(after: dotIndex)...]
                        if afterDot.count > 2 {
                            result = String(cleaned.prefix(through: cleaned.index(dotIndex, offsetBy: 2)))
                        }
                    }
                    
                    text = result
                }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue, lineWidth: 1)
                )
        )
    }
}

// Пример использования кастомного компонента
struct CustomDollarTextFieldExample: View {
    @State private var amount = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Кастомный DollarTextField")
                .font(.headline)
            
            DollarTextField(text: $amount, placeholder: "Введите сумму")
                .padding(.horizontal)
            
            if !amount.isEmpty {
                Text("Сумма: $\(amount)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
        }
        .padding()
    }
}

#Preview {
    VStack(spacing: 30) {
        DollarTextFieldExamples()
        Divider()
        CustomDollarTextFieldExample()
    }
} 