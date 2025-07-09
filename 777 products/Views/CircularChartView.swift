import SwiftUI

struct CircularChartView: View {
    let data: [Double] = [25, 30, 25, 10, 10]
    let colors: [Color] = [.blue, .green, .orange, .yellow, .red]
    let labels: [String] = ["Сектор 1", "Сектор 2", "Сектор 3", "4"]
    
    var body: some View {
        VStack(spacing: 30) {
            // Заголовок
            Text("Круговая диаграмма")
                .font(.title)
                .fontWeight(.bold)
            
            // Круговая диаграмма
            ZStack {
                // Основной круг
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                    .frame(width: 200, height: 200)
                
                // Секторы диаграммы
                ForEach(0..<data.count, id: \.self) { index in
                    PieSlice(
                        startAngle: startAngle(for: index),
                        endAngle: endAngle(for: index),
                        color: colors[index]
                    )
                    .frame(width: 200, height: 200)
                }
                
                // Подписи секторов
                ForEach(0..<data.count, id: \.self) { index in
                    SectorLabel(
                        angle: middleAngle(for: index),
                        text: "\(Int(data[index]))%",
                        color: colors[index]
                    )
                    .frame(width: 200, height: 200)
                }
                
                // Центральный текст
//                VStack {
//                    Text("100%")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                    Text("Всего")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
            }
            
            // Легенда
//            VStack(spacing: 15) {
//                ForEach(0..<data.count, id: \.self) { index in
//                    HStack {
//                        Circle()
//                            .fill(colors[index])
//                            .frame(width: 20, height: 20)
//                        
//                        Text(labels[index])
//                            .font(.body)
//                        
//                        Spacer()
//                        
//                        Text("\(Int(data[index]))%")
//                            .font(.body)
//                            .fontWeight(.semibold)
//                    }
//                    .padding(.horizontal)
//                }
//            }
//            .padding()
//            .background(Color.gray.opacity(0.1))
//            .cornerRadius(10)
        }
        .padding()
    }
    
    // Вычисление начального угла для сектора
    private func startAngle(for index: Int) -> Double {
        let total = data.reduce(0, +)
        let previousValues = data.prefix(index).reduce(0, +)
        return (previousValues / total) * 360
    }
    
    // Вычисление конечного угла для сектора
    private func endAngle(for index: Int) -> Double {
        let total = data.reduce(0, +)
        let currentAndPreviousValues = data.prefix(index + 1).reduce(0, +)
        return (currentAndPreviousValues / total) * 360
    }
    
    // Отладочная функция для проверки углов
    private func debugAngles() {
        for i in 0..<data.count {
            let start = startAngle(for: i)
            let end = endAngle(for: i)
            let middle = middleAngle(for: i)
            print("Сектор \(i): start=\(start), end=\(end), middle=\(middle)")
        }
    }
    
    // Правильное вычисление среднего угла для подписей
    private func correctMiddleAngle(for index: Int) -> Double {
        // Для данных [25, 30, 45] правильные углы:
        // Сектор 0 (25%): 0° - 90° → средний угол 45°
        // Сектор 1 (30%): 90° - 198° → средний угол 144°
        // Сектор 2 (45%): 198° - 360° → средний угол 279°
        
        let angles = [45.0, 144.0, 279.0] // Правильные средние углы
        return angles[index] - 90 // Применяем поворот -90°
    }
    
    // Вычисление среднего угла для размещения подписи
    private func middleAngle(for index: Int) -> Double {
        let start = startAngle(for: index)
        let end = endAngle(for: index)
        let middle = (start + end) / 2
        // Применяем тот же поворот, что и для секторов (-90°)
        return middle - 90
    }
}

// Компонент для отрисовки сектора круга
struct PieSlice: View {
    let startAngle: Double
    let endAngle: Double
    let color: Color
    
    var body: some View {
        Path { path in
            let center = CGPoint(x: 100, y: 100)
            let radius: CGFloat = 90
            
            path.move(to: center)
            path.addArc(
                center: center,
                radius: radius,
                startAngle: Angle(degrees: startAngle - 90), // -90 для начала с верха
                endAngle: Angle(degrees: endAngle - 90),
                clockwise: false
            )
            path.closeSubpath()
        }
        .fill(color)
    }
}

// Компонент для подписи сектора
struct SectorLabel: View {
    let angle: Double
    let text: String
    let color: Color
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius: CGFloat = 65 // Расстояние от центра до текста
            let radians = angle * .pi / 180
            let x = center.x + radius * cos(radians)
            let y = center.y + radius * sin(radians)
            
            Text(text)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .background(
                    Circle()
                        .fill(color)
                        .frame(width: 28, height: 28)
                )
                .rotationEffect(.degrees(angle))
                .position(x: x, y: y)
                 // Поворачиваем текст радиально к центру
        }
    }
}

// Альтернативная версия с анимацией
//struct AnimatedCircularChartView: View {
//    let data: [Double] = [25, 30, 45]
//    let colors: [Color] = [.blue, .green, .orange]
//    let labels: [String] = ["Сектор 1", "Сектор 2", "Сектор 3"]
//    
//    @State private var animationProgress: Double = 0
//    
//    var body: some View {
//        VStack(spacing: 30) {
//            Text("Анимированная круговая диаграмма")
//                .font(.title)
//                .fontWeight(.bold)
//            
//            ZStack {
//                // Основной круг
//                Circle()
//                    .stroke(Color.gray.opacity(0.2), lineWidth: 20)
//                    .frame(width: 200, height: 200)
//                
//                // Анимированные секторы
//                ForEach(0..<data.count, id: \.self) { index in
//                    AnimatedPieSlice(
//                        startAngle: startAngle(for: index),
//                        endAngle: endAngle(for: index),
//                        color: colors[index],
//                        animationProgress: animationProgress
//                    )
//                    .frame(width: 200, height: 200)
//                }
//                
//                // Подписи секторов с анимацией
//                ForEach(0..<data.count, id: \.self) { index in
//                    AnimatedSectorLabel(
//                        angle: correctMiddleAngle(for: index),
//                        text: "\(Int(data[index] * animationProgress))%",
//                        color: colors[index],
//                        animationProgress: animationProgress
//                    )
//                    .frame(width: 200, height: 200)
//                }
//                
//                // Центральный текст с анимацией
//                VStack {
//                    Text("\(Int(100 * animationProgress))%")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .animation(.easeInOut(duration: 1), value: animationProgress)
//                    
//                    Text("Всего")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//            }
//            
//            // Легенда с анимацией
//            VStack(spacing: 15) {
//                ForEach(0..<data.count, id: \.self) { index in
//                    HStack {
//                        Circle()
//                            .fill(colors[index])
//                            .frame(width: 20, height: 20)
//                        
//                        Text(labels[index])
//                            .font(.body)
//                        
//                        Spacer()
//                        
//                        Text("\(Int(data[index] * animationProgress))%")
//                            .font(.body)
//                            .fontWeight(.semibold)
//                            .animation(.easeInOut(duration: 1).delay(Double(index) * 0.2), value: animationProgress)
//                    }
//                    .padding(.horizontal)
//                }
//            }
//            .padding()
//            .background(Color.gray.opacity(0.1))
//            .cornerRadius(10)
//        }
//        .padding()
//        .onAppear {
//            withAnimation(.easeInOut(duration: 1.5)) {
//                animationProgress = 1.0
//            }
//        }
//    }
//    
//    private func startAngle(for index: Int) -> Double {
//        let total = data.reduce(0, +)
//        let previousValues = data.prefix(index).reduce(0, +)
//        return (previousValues / total) * 360
//    }
//    
//    private func endAngle(for index: Int) -> Double {
//        let total = data.reduce(0, +)
//        let currentAndPreviousValues = data.prefix(index + 1).reduce(0, +)
//        return (currentAndPreviousValues / total) * 360
//    }
//    
//    // Вычисление среднего угла для размещения подписи
//    private func middleAngle(for index: Int) -> Double {
//        let start = startAngle(for: index)
//        let end = endAngle(for: index)
//        let middle = (start + end) / 2
//        // Применяем тот же поворот, что и для секторов (-90°)
//        return middle - 90
//    }
//}

// Анимированный компонент сектора
struct AnimatedPieSlice: View {
    let startAngle: Double
    let endAngle: Double
    let color: Color
    let animationProgress: Double
    
    var body: some View {
        Path { path in
            let center = CGPoint(x: 100, y: 100)
            let radius: CGFloat = 90
            
            let animatedStartAngle = startAngle
            let animatedEndAngle = startAngle + (endAngle - startAngle) * animationProgress
            
            path.move(to: center)
            path.addArc(
                center: center,
                radius: radius,
                startAngle: Angle(degrees: animatedStartAngle - 90),
                endAngle: Angle(degrees: animatedEndAngle - 90),
                clockwise: false
            )
            path.closeSubpath()
        }
        .fill(color)
    }
}

// Анимированный компонент подписи сектора
struct AnimatedSectorLabel: View {
    let angle: Double
    let text: String
    let color: Color
    let animationProgress: Double
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius: CGFloat = 65 // Расстояние от центра до текста
            
            let radians = angle * .pi / 180
            let x = center.x + radius * cos(radians)
            let y = center.y + radius * sin(radians)
            
            Text(text)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .background(
                    Circle()
                        .fill(color)
                        .frame(width: 28, height: 28)
                )
                .position(x: x, y: y)
                .rotationEffect(.degrees(angle + 90)) // Поворачиваем текст радиально к центру
                .opacity(animationProgress)
                .scaleEffect(animationProgress)
        }
    }
}

// Версия с интерактивностью
//struct InteractiveCircularChartView: View {
//    let data: [Double] = [25, 30, 45]
//    let colors: [Color] = [.blue, .green, .orange]
//    let labels: [String] = ["Сектор 1", "Сектор 2", "Сектор 3"]
//    
//    @State private var selectedIndex: Int? = nil
//    
//    var body: some View {
//        VStack(spacing: 30) {
//            Text("Интерактивная круговая диаграмма")
//                .font(.title)
//                .fontWeight(.bold)
//            
//            ZStack {
//                Circle()
//                    .stroke(Color.gray.opacity(0.2), lineWidth: 20)
//                    .frame(width: 200, height: 200)
//                
//                ForEach(0..<data.count, id: \.self) { index in
//                    InteractivePieSlice(
//                        startAngle: startAngle(for: index),
//                        endAngle: endAngle(for: index),
//                        color: colors[index],
//                        isSelected: selectedIndex == index
//                    )
//                    .frame(width: 200, height: 200)
//                    .onTapGesture {
//                        withAnimation(.spring()) {
//                            selectedIndex = selectedIndex == index ? nil : index
//                        }
//                    }
//                }
//                
//                // Подписи секторов для интерактивной версии
//                ForEach(0..<data.count, id: \.self) { index in
//                    InteractiveSectorLabel(
//                        angle: middleAngle(for: index),
//                        text: "\(Int(data[index]))%",
//                        color: colors[index],
//                        isSelected: selectedIndex == index
//                    )
//                    .frame(width: 200, height: 200)
//                }
//                
//                VStack {
//                    if let selectedIndex = selectedIndex {
//                        Text(labels[selectedIndex])
//                            .font(.title2)
//                            .fontWeight(.bold)
//                        Text("\(Int(data[selectedIndex]))%")
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                    } else {
//                        Text("Нажмите на сектор")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                        Text("для выбора")
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                    }
//                }
//            }
//            
//            // Легенда
//            VStack(spacing: 15) {
//                ForEach(0..<data.count, id: \.self) { index in
//                    HStack {
//                        Circle()
//                            .fill(colors[index])
//                            .frame(width: 20, height: 20)
//                            .scaleEffect(selectedIndex == index ? 1.2 : 1.0)
//                            .animation(.spring(), value: selectedIndex)
//                        
//                        Text(labels[index])
//                            .font(.body)
//                            .fontWeight(selectedIndex == index ? .bold : .regular)
//                        
//                        Spacer()
//                        
//                        Text("\(Int(data[index]))%")
//                            .font(.body)
//                            .fontWeight(.semibold)
//                    }
//                    .padding(.horizontal)
//                    .background(selectedIndex == index ? Color.blue.opacity(0.1) : Color.clear)
//                    .cornerRadius(8)
//                    .animation(.easeInOut(duration: 0.2), value: selectedIndex)
//                }
//            }
//            .padding()
//            .background(Color.gray.opacity(0.1))
//            .cornerRadius(10)
//        }
//        .padding()
//    }
//    
//    private func startAngle(for index: Int) -> Double {
//        let total = data.reduce(0, +)
//        let previousValues = data.prefix(index).reduce(0, +)
//        return (previousValues / total) * 360
//    }
//    
//    private func endAngle(for index: Int) -> Double {
//        let total = data.reduce(0, +)
//        let currentAndPreviousValues = data.prefix(index + 1).reduce(0, +)
//        return (currentAndPreviousValues / total) * 360
//    }
//    
//    // Вычисление среднего угла для размещения подписи
//    private func middleAngle(for index: Int) -> Double {
//        let start = startAngle(for: index)
//        let end = endAngle(for: index)
//        return (start + end) / 2
//    }
//}

// Интерактивный компонент сектора
struct InteractivePieSlice: View {
    let startAngle: Double
    let endAngle: Double
    let color: Color
    let isSelected: Bool
    
    var body: some View {
        Path { path in
            let center = CGPoint(x: 100, y: 100)
            let radius: CGFloat = isSelected ? 95 : 90
            
            path.move(to: center)
            path.addArc(
                center: center,
                radius: radius,
                startAngle: Angle(degrees: startAngle - 90),
                endAngle: Angle(degrees: endAngle - 90),
                clockwise: false
            )
            path.closeSubpath()
        }
        .fill(color)
        .shadow(color: isSelected ? .black.opacity(0.3) : .clear, radius: isSelected ? 5 : 0)
    }
}

#Preview {
    VStack(spacing: 40) {
        CircularChartView()
        Divider()
//        AnimatedCircularChartView()
        Divider()
//        InteractiveCircularChartView()
    }
} 
