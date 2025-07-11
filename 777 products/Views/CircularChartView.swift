import SwiftUI

struct CircularChartView: View {
    let data: [(color: Color, percentage: Double)]
    
    var body: some View {
        ZStack {
            ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                Circle()
                    .trim(from: startAngle(for: index), to: endAngle(for: index))
                    .stroke(item.color, lineWidth: 30)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.0), value: item.percentage)
            }
        }
        .frame(width: 200, height: 200)
    }
    
    private func startAngle(for index: Int) -> Double {
        let previousPercentages = data.prefix(index).map { $0.percentage }
        let previousTotal = previousPercentages.reduce(0, +)
        return previousTotal / 100.0
    }
    
    private func endAngle(for index: Int) -> Double {
        let previousPercentages = data.prefix(index + 1).map { $0.percentage }
        let total = previousPercentages.reduce(0, +)
        return total / 100.0
    }
}

#Preview {
    CircularChartView(data: [
        (Color.blue, 30),
        (Color.green, 25),
        (Color.orange, 20),
        (Color.red, 15),
        (Color.purple, 10)
    ])
} 
