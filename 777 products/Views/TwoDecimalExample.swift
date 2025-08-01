import SwiftUI

struct TwoDecimalExample: View {
    let testNumbers: [Double] = [1.0, 1.5, 1.567, 2.0, 2.25, 3.0, 0.0, 10.0, 15.75, 100.0]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Форматирование с 2 знаками после запятой")
                .font(.title)
                .fontWeight(.bold)
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(testNumbers, id: \.self) { number in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Исходное число: \(number)")
                                .font(.headline)
                            
                            HStack {
                                Text("twoDecimalString:")
                                    .font(.body)
                                    .foregroundColor(.blue)
                                Text("'\(number.twoDecimalString)'")
                                    .font(.body)
                                    .fontWeight(.bold)
                            }
                            
                            HStack {
                                Text("currencyTwoDecimalString:")
                                    .font(.body)
                                    .foregroundColor(.green)
                                Text("'\(number.currencyTwoDecimalString)'")
                                    .font(.body)
                                    .fontWeight(.bold)
                            }
                            
                            HStack {
                                Text("cleanString:")
                                    .font(.body)
                                    .foregroundColor(.gray)
                                Text("'\(number.cleanString)'")
                                    .font(.body)
                                    .fontWeight(.medium)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            
            // Практический пример
            VStack(spacing: 12) {
                Text("Практический пример:")
                    .font(.headline)
                
                let price: Double = 15.5
                let quantity: Double = 3
                let total = price * quantity
                
                HStack {
                    Text("Цена:")
                    Spacer()
                    Text(price.currencyTwoDecimalString)
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Количество:")
                    Spacer()
                    Text("\(quantity.twoDecimalString)")
                        .fontWeight(.bold)
                }
                
                HStack {
                    Text("Итого:")
                    Spacer()
                    Text(total.currencyTwoDecimalString)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(12)
        }
        .padding()
    }
}

#Preview {
    TwoDecimalExample()
} 