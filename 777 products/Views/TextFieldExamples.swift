import SwiftUI

struct TextFieldExamples: View {
    // Основные переменные для демонстрации
    @State private var simpleText = ""
    @State private var emailText = ""
    @State private var passwordText = ""
    @State private var numberText = ""
    @State private var multilineText = ""
    @State private var searchText = ""
    @State private var phoneText = ""
    @State private var isSecure = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                // 1. Простой TextField
                VStack(alignment: .leading, spacing: 10) {
                    Text("1. Простой TextField")
                        .font(.headline)
                    
                    TextField("Введите ваше имя", text: $simpleText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Text("Введенный текст: \(simpleText)")
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // 2. TextField с кастомным стилем
                VStack(alignment: .leading, spacing: 10) {
                    Text("2. Кастомный стиль")
                        .font(.headline)
                    
                    TextField("Введите email", text: $emailText)
                        .textFieldStyle(CustomTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                }
                
                Divider()
                
                // 3. Secure TextField (пароль)
                VStack(alignment: .leading, spacing: 10) {
                    Text("3. Secure TextField")
                        .font(.headline)
                    
                    HStack {
                        if isSecure {
                            SecureField("Введите пароль", text: $passwordText)
                        } else {
                            TextField("Введите пароль", text: $passwordText)
                        }
                        
                        Button(action: {
                            isSecure.toggle()
                        }) {
                            Image(systemName: isSecure ? "eye.slash" : "eye")
                                .foregroundColor(.blue)
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                }
                
                Divider()
                
                // 4. TextField с валидацией
                VStack(alignment: .leading, spacing: 10) {
                    Text("4. Валидация")
                        .font(.headline)
                    
                    TextField("Введите число", text: $numberText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .onChange(of: numberText) { newValue in
                            // Фильтруем только цифры
                            numberText = newValue.filter { $0.isNumber }
                        }
                        .padding(.horizontal)
                    
                    if !numberText.isEmpty {
                        Text("Введено: \(numberText)")
                            .foregroundColor(.green)
                    }
                }
                
                Divider()
                
                // 5. TextField с поиском
                VStack(alignment: .leading, spacing: 10) {
                    Text("5. Поиск")
                        .font(.headline)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Поиск...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    if !searchText.isEmpty {
                        Text("Результаты поиска для: \(searchText)")
                            .foregroundColor(.secondary)
                    }
                }
                
                Divider()
                
                // 6. TextField с форматированием
                VStack(alignment: .leading, spacing: 10) {
                    Text("6. Форматирование телефона")
                        .font(.headline)
                    
                    TextField("+7 (___) ___-__-__", text: $phoneText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.phonePad)
                        .onChange(of: phoneText) { newValue in
                            phoneText = formatPhoneNumber(newValue)
                        }
                        .padding(.horizontal)
                }
                
                Divider()
                
                // 7. TextField с ограничением символов
                VStack(alignment: .leading, spacing: 10) {
                    Text("7. Ограничение символов")
                        .font(.headline)
                    
                    TextField("Максимум 10 символов", text: $simpleText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: simpleText) { newValue in
                            if newValue.count > 10 {
                                simpleText = String(newValue.prefix(10))
                            }
                        }
                        .padding(.horizontal)
                    
                    Text("\(simpleText.count)/10 символов")
                        .foregroundColor(simpleText.count > 8 ? .red : .secondary)
                }
                
                Divider()
                
                // 8. TextField с действиями
                VStack(alignment: .leading, spacing: 10) {
                    Text("8. Действия")
                        .font(.headline)
                    
                    TextField("Нажмите Enter", text: $simpleText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            print("Пользователь нажал Enter")
                        }
                        .onTapGesture {
                            print("TextField нажат")
                        }
                        .padding(.horizontal)
                }
            }
            .padding()
        }
    }
    
    // Функция форматирования номера телефона
    private func formatPhoneNumber(_ number: String) -> String {
        let cleaned = number.filter { $0.isNumber }
        let mask = "+7 (___) ___-__-__"
        var result = ""
        var index = cleaned.startIndex
        
        for ch in mask where index < cleaned.endIndex {
            if ch == "_" {
                result.append(cleaned[index])
                index = cleaned.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}

// Кастомный стиль для TextField
struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            )
            .padding(.horizontal)
    }
}

// Пример с фокусом
struct FocusedTextFieldExample: View {
    @State private var text1 = ""
    @State private var text2 = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Управление фокусом")
                .font(.headline)
            
            TextField("Первое поле", text: $text1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isFocused)
            
            TextField("Второе поле", text: $text2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Фокус на первое поле") {
                isFocused = true
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

// Пример с валидацией email
struct EmailValidationExample: View {
    @State private var email = ""
    @State private var isValidEmail = false
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Валидация Email")
                .font(.headline)
            
            TextField("Введите email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .onChange(of: email) { newValue in
                    isValidEmail = isValidEmailFormat(newValue)
                }
            
            HStack {
                Image(systemName: isValidEmail ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(isValidEmail ? .green : .red)
                
                Text(isValidEmail ? "Валидный email" : "Невалидный email")
                    .foregroundColor(isValidEmail ? .green : .red)
            }
        }
        .padding()
    }
    
    private func isValidEmailFormat(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

// Пример с автодополнением
struct AutocompleteExample: View {
    @State private var searchText = ""
    @State private var suggestions: [String] = []
    
    let allItems = ["Apple", "Banana", "Cherry", "Date", "Elderberry", "Fig", "Grape"]
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Автодополнение")
                .font(.headline)
            
            TextField("Поиск фруктов...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: searchText) { newValue in
                    if newValue.isEmpty {
                        suggestions = []
                    } else {
                        suggestions = allItems.filter { $0.lowercased().contains(newValue.lowercased()) }
                    }
                }
            
            if !suggestions.isEmpty {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(suggestions, id: \.self) { suggestion in
                        Button(suggestion) {
                            searchText = suggestion
                            suggestions = []
                        }
                        .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
        }
        .padding()
    }
}

#Preview {
    VStack(spacing: 30) {
        TextFieldExamples()
        Divider()
        FocusedTextFieldExample()
        Divider()
        EmailValidationExample()
        Divider()
        AutocompleteExample()
    }
} 
