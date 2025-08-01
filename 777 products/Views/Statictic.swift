//
//  Statictic.swift
//  777 products
//
//  Created by Алкександр Степанов on 09.07.2025.
//

import SwiftUI

struct Statictic: View {
    @AppStorage("bgNimber") var bgNumber = 1
    @AppStorage("selectedMenu") var selectedMenu = 0
    @AppStorage("weekly") var weekly = true
    @AppStorage("weeklyLimit") var weeklyLimit = "$3000"
    @AppStorage("monthlyLimit") var monthlyLimit = "$12000"
    @State private var sortType = 0
    @State private var сurentDate = Date()
    @State private var dateString: String = ""
    @State private var dateStringForCategoryStatistic: String = ""
    @State private var listArray = UserDefaults.standard.array(forKey: "listArray") as? [[String]] ?? []
    @State private var allTypeProductArray = Arrays.startTemplatesArray
    @State private var data: [Double] = [0,0,0,0,0,0,0,0,0,0,0,0]
    @State private var totalCategory: Double = 0
    @State private var totalMonth: Double = 0
    @State private var totalWeek: Double = 0
    let colors: [Color] = [.red, .blue, .green, .orange, .purple, .pink,
                           .yellow, .cyan, .mint, .indigo, .brown, .gray]
    @State private var monthlyStatisticArray = Arrays.montlyStatisticList
    @State private var weeklyStatisticArray = Arrays.weeklyStatisticList
    @State private var weeklyDaysArrays: [[String]] = []
    @State private var everyDaysArrays: [String] = Array(repeating: "1", count: 7)
    var body: some View {
        ZStack {
            Background(backgroundNumber: bgNumber)
            VStack(spacing: screenHeight*0.03) {
                Image(.settingsFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.071)
                    .overlay(
                        VStack {
                            Text(formatDate(Date()))
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                .foregroundColor(.textYellow)
                            HStack(spacing: screenHeight*0.05) {
                                Image(sortType == 0 ? .settingOn : .settingOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenHeight*0.1)
                                    .overlay(
                                        Text("WEEKLY")
                                            .font(Font.custom("Green Mountain 3", size: screenHeight*0.013))
                                            .foregroundColor(.white)
                                            .offset(y: sortType == 0 ? 0 : -screenHeight*0.003)
                                    )
                                    .onTapGesture {
                                        sortType = 0
                                    }
                                Image(sortType == 1 ? .settingOn : .settingOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenHeight*0.1)
                                    .overlay(
                                        Text("MONTHLY")
                                            .font(Font.custom("Green Mountain 3", size: screenHeight*0.013))
                                            .foregroundColor(.white)
                                            .offset(y: sortType == 1 ? 0 : -screenHeight*0.003)
                                    )
                                    .onTapGesture {
                                        sortType = 1
                                    }
                                Image(sortType == 2 ? .settingOn : .settingOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenHeight*0.1)
                                    .overlay(
                                        Text("CATEGORY")
                                            .font(Font.custom("Green Mountain 3", size: screenHeight*0.013))
                                            .foregroundColor(.white)
                                            .offset(y: sortType == 2 ? 0 : -screenHeight*0.003)
                                    )
                                    .onTapGesture {
                                        sortType = 2
                                    }
                            }
                        }
                    )
                if sortType == 2 {
                    Image(.limitFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.05)
                        .overlay(
                            ZStack {
                                HStack {
                                    Image(.buttonOff)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenHeight*0.025)
                                        .onTapGesture {
                                            decreasedDateByMonth()
                                            createStatisticArray()
                                        }
                                    RoundedRectangle(cornerRadius: screenHeight*0.01)
                                        .frame(width: screenHeight*0.3, height: screenHeight*0.037)
                                        .foregroundColor(.white)
                                        .overlay(
                                            Text(getBigMonth(date: dateString))
                                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                                .foregroundColor(.red)
                                            
                                        )
                                    Image(.buttonOff)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenHeight*0.025)
                                        .onTapGesture {
                                            increasedDateByMonth()
                                            createStatisticArray()
                                        }
                                }
                                //                                .offset(x: screenHeight*0.055)
                            }
                        )
                    Image(.whiteRectangle)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.44)
                        .overlay(
                            ZStack {
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
                                    if data[index] != 0 {
                                        SectorLabel(
                                            angle: middleAngle(for: index),
                                            text: "\(Int(data[index]))%",
                                            color: colors[index],
                                            image: allTypeProductArray[index][1]
                                            
                                        )
                                        .frame(width: 200, height: 200)
                                    }
                                }
                            }
                        )
                    Image(.totalFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.07)
                        .overlay(
                            Text("$\(totalCategory.twoDecimalString)")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.04))
                                .foregroundColor(.red)
                                .shadow(color: .black, radius: 1)
                                .shadow(color: .black, radius: 1)
                                .offset(x: screenHeight*0.06, y: -screenHeight*0.002)
                        )
                    Image(.statisticLimitFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.07)
                        .overlay(
                            Text(monthlyLimit)
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.04))
                                .foregroundColor(.green)
                                .shadow(color: .black, radius: 1)
                                .shadow(color: .black, radius: 1)
                                .offset(x: screenHeight*0.06, y: -screenHeight*0.002)
                            )
                    Spacer()
                }
                if sortType == 1 {
                    Image(.limitFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.05)
                        .overlay(
                            ZStack {
                                HStack {
                                    Image(.buttonOff)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenHeight*0.025)
                                        .onTapGesture {
                                            decreasedDateByMonth()
                                            weeklyDaysArrays = createWeeklyArraysForMonth(dateString: dateString)
                                            updateAmountArrays()
                                        }
                                    RoundedRectangle(cornerRadius: screenHeight*0.01)
                                        .frame(width: screenHeight*0.3, height: screenHeight*0.037)
                                        .foregroundColor(.white)
                                        .overlay(
                                            Text(getBigMonth(date: dateString))
                                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                                .foregroundColor(.red)
                                            
                                        )
                                    Image(.buttonOff)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenHeight*0.025)
                                        .onTapGesture {
                                            increasedDateByMonth()
                                            weeklyDaysArrays = createWeeklyArraysForMonth(dateString: dateString)
                                            updateAmountArrays()
                                        }
                                }
                            }
                        )
                    Image(.monthRectangle)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.23)
                        .overlay(
                            VStack {
                                ForEach(0..<monthlyStatisticArray.count, id: \.self) { item in
                                    VStack {
                                        HStack {
                                            Image(.blackRectangle)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: screenHeight*0.025)
                                                .overlay(
                                                    Text(monthlyStatisticArray[item].name)
                                                        .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                                        .foregroundColor(.red)
                                                )
                                            //                                        Spacer()
                                            Image(.greenRectangle)
                                                .resizable()
//                                                .scaledToFit()
                                                .frame(width: screenHeight*0.19*monthlyStatisticArray[item].scaleIndex, height: screenHeight*0.025)
                                            Spacer()
                                            Text("$\(monthlyStatisticArray[item].amount.twoDecimalString)")
                                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.025))
                                                .foregroundColor(.red)
                                                .shadow(color: .black, radius: 1)
                                                .shadow(color: .black, radius: 1)
                                        }
                                        .frame(maxWidth: screenHeight*0.43)
                                        Image(.blackLine)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.001)
                                    }
                                }
                            }
                        )
                    Spacer()
                    Image(.totalFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.07)
                        .overlay(
                            Text("$\(totalMonth.twoDecimalString)")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.04))
                                .foregroundColor(.red)
                                .shadow(color: .black, radius: 1)
                                .shadow(color: .black, radius: 1)
                                .offset(x: screenHeight*0.06, y: -screenHeight*0.002)
                        )
                    Image(.statisticLimitFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.07)
                        .overlay(
                            Text(monthlyLimit)
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.04))
                                .foregroundColor(.green)
                                .shadow(color: .black, radius: 1)
                                .shadow(color: .black, radius: 1)
                                .offset(x: screenHeight*0.06, y: -screenHeight*0.002)
                            )
                        .padding(.bottom, screenHeight*0.07)
//                    Spacer()
                }
                if sortType == 0 {
                    Image(.limitFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.05)
                        .overlay(
                            ZStack {
                                HStack {
                                    Image(.buttonOff)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenHeight*0.025)
                                        .onTapGesture {
                                            decreasedDateByDay()
                                            everyDaysArrays = createWeekArrayWithDateInCenter(dateString: dateString)
                                            updateAmountArraysForDays()
                                        }
                                    RoundedRectangle(cornerRadius: screenHeight*0.01)
                                        .frame(width: screenHeight*0.3, height: screenHeight*0.037)
                                        .foregroundColor(.white)
                                        .overlay(
                                            Text(getDayAndMonth(date: dateString))
                                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                                .foregroundColor(.red)
                                            
                                        )
                                    Image(.buttonOff)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenHeight*0.025)
                                        .onTapGesture {
                                            increasedDateByDay()
                                            everyDaysArrays = createWeekArrayWithDateInCenter(dateString: dateString)
                                            updateAmountArraysForDays()
                                        }
                                }
                            }
                        )
                    Image(.weekRectangle)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.365)
                        .overlay(
                            VStack {
                                ForEach(0..<weeklyStatisticArray.count, id: \.self) { item in
                                    VStack {
                                        HStack {
                                            Image(.blackRectangle)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: screenHeight*0.025)
                                                .overlay(
                                                    Text(formateWeekDay(date: everyDaysArrays[item]))
                                                        .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                                        .foregroundColor(.red)
                                                )
                                            //                                        Spacer()
                                            Image(.greenRectangle)
                                                .resizable()
//                                                .scaledToFit()
                                                .frame(width: screenHeight*0.19*weeklyStatisticArray[item].scaleIndex, height: screenHeight*0.025)
                                            Spacer()
                                            Text("$\(weeklyStatisticArray[item].amount.twoDecimalString)")
                                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.025))
                                                .foregroundColor(.red)
                                                .shadow(color: .black, radius: 1)
                                                .shadow(color: .black, radius: 1)
                                        }
                                        .frame(maxWidth: screenHeight*0.43)
                                        Image(.blackLine)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.001)
                                    }
                                }
                            }
                        )
                    Spacer()
                    
                    Image(.totalFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.07)
                        .overlay(
                            Text("$\(totalWeek.twoDecimalString)")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.04))
                                .foregroundColor(.red)
                                .shadow(color: .black, radius: 1)
                                .shadow(color: .black, radius: 1)
                                .offset(x: screenHeight*0.06, y: -screenHeight*0.002)
                        )
                    Image(.statisticLimitFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.07)
                        .overlay(
                            Text(weeklyLimit)
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.04))
                                .foregroundColor(.green)
                                .shadow(color: .black, radius: 1)
                                .shadow(color: .black, radius: 1)
                                .offset(x: screenHeight*0.06, y: -screenHeight*0.002)
                            )
                        .padding(.bottom, screenHeight*0.07)
                }
            }
            BottomBar()
        }
        
        .onAppear {
            getStringDate()
            createStatisticArray()
            calculateTotalCategory()
            weeklyDaysArrays = createWeeklyArraysForMonth(dateString: dateString)
            updateAmountArrays()
            everyDaysArrays = createWeekArrayWithDateInCenter(dateString: dateString)
            updateAmountArraysForDays()
        }
        
    }
    
    func calculateTotalCategory() {
        for i in 0..<data.count {
            totalCategory += data[i]
        }
    }
    
    func createStatisticArray() {
        data = [0,0,0,0,0,0,0,0,0,0,0,0]
        for i in 0..<listArray.count {
            var categryIndex = 0
            if listArray[i][6] == "1"
                && getBigMonth(date: listArray[i][0]) ==  getBigMonth(date:dateString)
            {
                categryIndex = allTypeProductArray.firstIndex(where: {$0[1] == listArray[i][1]}) ?? 0
                data[categryIndex] += Double(listArray[i][5]) ?? 0
            }
        }
    }
    
    func increasedDateByDay() {
        let formatter = Formatter()
        let oldDate = dateString
        dateString = formatter.increaseDateByOneDay(oldDate)
    }
    
    func decreasedDateByDay() {
        let formatter = Formatter()
        let oldDate = dateString
        dateString = formatter.decreaseDateByOneDay(oldDate)
    }
    
    func increasedDateByMonth() {
        let formatter = Formatter()
        let oldDate = dateString
        dateString = formatter.increaseDateByOneMonth(oldDate)
    }
    
    func decreasedDateByMonth() {
        let formatter = Formatter()
        let oldDate = dateString
        dateString = formatter.decreaseDateByOneMonth(oldDate)
    }
    
    func getStringDate() {
        dateString = сurentDate.toShortFormat()
    }
    
    func getDayAndMonth(date: String) -> String {
        let formatter = Formatter()
        return formatter.getMonthAndDay(date)
    }
    
    func getBigMonth(date: String) -> String {
        let formatter = Formatter()
        return formatter.getBigMonth(date)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
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
    
    // Вычисление среднего угла для размещения подписи
    private func middleAngle(for index: Int) -> Double {
        let start = startAngle(for: index)
        let end = endAngle(for: index)
        let middle = (start + end) / 2
        // Применяем тот же поворот, что и для секторов (-90°)
        return middle - 90
    }
    
    func formateWeekDay(date: String) -> String {
        let dateFormatter = Formatter()
        let weekDay = dateFormatter.getWeekdayAbbreviation(date)
        return weekDay
    }
    
    func createWeeklyArraysForMonth(dateString: String) -> [[String]] {
        let calendar = Calendar.current
        
        // Парсим входную дату
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        
        guard let inputDate = dateFormatter.date(from: dateString) else {
            return [[], [], [], []]
        }
        
        // Получаем компоненты даты
        let year = calendar.component(.year, from: inputDate)
        let month = calendar.component(.month, from: inputDate)
        
        // Создаем дату первого дня месяца
        var firstDayComponents = DateComponents()
        firstDayComponents.year = year
        firstDayComponents.month = month
        firstDayComponents.day = 1
        
        guard let firstDayOfMonth = calendar.date(from: firstDayComponents) else {
            return [[], [], [], []]
        }
        
        // Получаем количество дней в месяце
        let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth)!
        let daysInMonth = range.count
        
        // Создаем 4 массива для недель
        var weeklyArrays: [[String]] = [[], [], [], []]
        
        // Разбиваем месяц на недели (по 7 дней)
        let weeksInMonth = (daysInMonth + 6) / 7 // Округляем вверх
        
        for week in 0..<min(4, weeksInMonth) {
            let startDay = week * 7 + 1
            let endDay = min((week + 1) * 7, daysInMonth)
            
            for day in startDay...endDay {
                // Создаем дату для текущего дня
                var dayComponents = DateComponents()
                dayComponents.year = year
                dayComponents.month = month
                dayComponents.day = day
                
                guard let currentDate = calendar.date(from: dayComponents) else { continue }
                
                // Форматируем дату в нужный формат
                let dateString = dateFormatter.string(from: currentDate)
                weeklyArrays[week].append(dateString)
            }
        }
        
        return weeklyArrays
    }
    
    func updateAmountArrays() {
        monthlyStatisticArray = Arrays.montlyStatisticList
        for i in 0..<listArray.count {
            if weeklyDaysArrays[0].contains(where: { $0 == listArray[i][0] }) && listArray[i][6] == "1" {
                monthlyStatisticArray[0].amount += Double(listArray[i][5]) ?? 0
            }
            if weeklyDaysArrays[1].contains(where: { $0 == listArray[i][0] }) && listArray[i][6] == "1" {
                monthlyStatisticArray[1].amount += Double(listArray[i][5]) ?? 0
            }
            if weeklyDaysArrays[2].contains(where: { $0 == listArray[i][0] }) && listArray[i][6] == "1" {
                monthlyStatisticArray[2].amount += Double(listArray[i][5]) ?? 0
            }
            if weeklyDaysArrays[3].contains(where: { $0 == listArray[i][0] }) && listArray[i][6] == "1" {
                monthlyStatisticArray[3].amount += Double(listArray[i][5]) ?? 0
            }
        }
        totalMonth = 0.0
        for i in 0..<monthlyStatisticArray.count {
            totalMonth += monthlyStatisticArray[i].amount
        }
        for i in 0..<monthlyStatisticArray.count {
            if monthlyStatisticArray[i].amount != 0 {
                monthlyStatisticArray[i].scaleIndex = monthlyStatisticArray[i].amount/totalMonth
            } else {
                monthlyStatisticArray[i].scaleIndex = 0
            }
        }
    }
    
    func createWeekArrayWithDateInCenter(dateString: String) -> [String] {
        let calendar = Calendar.current
        
        // Парсим входную дату
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        
        guard let centerDate = dateFormatter.date(from: dateString) else {
            return []
        }
        
        // Создаем массив для 7 дней
        var weekArray: [String] = []
        
        // Вычисляем дату за 3 дня до центральной даты
        guard let startDate = calendar.date(byAdding: .day, value: -3, to: centerDate) else {
            return []
        }
        
        // Добавляем 7 дней подряд
        for i in 0..<7 {
            guard let currentDate = calendar.date(byAdding: .day, value: i, to: startDate) else {
                continue
            }
            
            let dateString = dateFormatter.string(from: currentDate)
            weekArray.append(dateString)
        }
        
        return weekArray
    }
    
    func updateAmountArraysForDays() {
        weeklyStatisticArray = Arrays.weeklyStatisticList
        for i in 0..<listArray.count {
            if everyDaysArrays[0] == listArray[i][0] && listArray[i][6] == "1" {
                weeklyStatisticArray[0].amount += Double(listArray[i][5]) ?? 0
            }
            if everyDaysArrays[1] == listArray[i][0] && listArray[i][6] == "1" {
                weeklyStatisticArray[1].amount += Double(listArray[i][5]) ?? 0
            }
            if everyDaysArrays[2] == listArray[i][0] && listArray[i][6] == "1" {
                weeklyStatisticArray[2].amount += Double(listArray[i][5]) ?? 0
            }
            if everyDaysArrays[3] == listArray[i][0] && listArray[i][6] == "1" {
                weeklyStatisticArray[3].amount += Double(listArray[i][5]) ?? 0
            }
            if everyDaysArrays[4] == listArray[i][0] && listArray[i][6] == "1" {
                weeklyStatisticArray[4].amount += Double(listArray[i][5]) ?? 0
            }
            if everyDaysArrays[5] == listArray[i][0] && listArray[i][6] == "1" {
                weeklyStatisticArray[5].amount += Double(listArray[i][5]) ?? 0
            }
            if everyDaysArrays[6] == listArray[i][0] && listArray[i][6] == "1" {
                weeklyStatisticArray[6].amount += Double(listArray[i][5]) ?? 0
            }
        }
        totalWeek = 0.0
        for i in 0..<weeklyStatisticArray.count {
            totalWeek += weeklyStatisticArray[i].amount
        }
        for i in 0..<weeklyStatisticArray.count {
            if weeklyStatisticArray[i].amount != 0 {
                weeklyStatisticArray[i].scaleIndex = weeklyStatisticArray[i].amount/totalMonth
            } else {
                weeklyStatisticArray[i].scaleIndex = 0
            }
        }
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
            let radius: CGFloat = screenHeight*0.2
            
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
    let image: String
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius: CGFloat = screenHeight*0.14 // Расстояние от центра до текста
            let radians = angle * .pi / 180
            let x = center.x + radius * cos(radians)
            let y = center.y + radius * sin(radians)
            HStack {
                Text(text)
                    .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 1)
                    .shadow(color: .black, radius: 1)
                    .background(
                        Circle()
                            .fill(color)
                            .frame(width: 28, height: 28)
                    )
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .rotationEffect(.degrees(-angle))
            }
            .rotationEffect(.degrees(angle))
            .position(x: x, y: y)
        }
    }
}


#Preview {
    Statictic()
}
