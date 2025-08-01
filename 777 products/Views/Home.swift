//
//  Home.swift
//  777 products
//
//  Created by Алкександр Степанов on 09.07.2025.
//

import SwiftUI

struct Home: View {
    @AppStorage("bgNimber") var bgNumber = 1
    @AppStorage("selectedMenu") var selectedMenu = 0
    @AppStorage("weekly") var weekly = true
    @State private var selectedDate = Date()
    @State private var dateString: String = ""
    @State private var listArray = UserDefaults.standard.array(forKey: "listArray") as? [[String]] ?? []
    @State private var totalMonth: Double = 0
    @State private var totalWeek: Double = 0
    @State private var allTypeProductArray = Arrays.startTemplatesArray
    @State private var monthlyStatisticArray = Arrays.montlyStatisticList
    @State private var weeklyStatisticArray = Arrays.weeklyStatisticList
    @State private var weeklyDaysArrays: [[String]] = []
    @State private var everyDaysArrays: [String] = Array(repeating: "1", count: 7)
    var body: some View {
        ZStack {
            Background(backgroundNumber: bgNumber)
            VStack {
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
                                Image(weekly ? .settingOn : .settingOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenHeight*0.1)
                                    .overlay(
                                        Text("WEEKLY")
                                            .font(Font.custom("Green Mountain 3", size: screenHeight*0.015))
                                            .foregroundColor(.white)
                                            .offset(y: weekly ? 0 : -screenHeight*0.003)
                                    )
                                    .onTapGesture {
                                        weekly = true
                                    }
                                Image(!weekly ? .settingOn : .settingOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenHeight*0.1)
                                    .overlay(
                                        Text("MONTHLY")
                                            .font(Font.custom("Green Mountain 3", size: screenHeight*0.015))
                                            .foregroundColor(.white)
                                            .offset(y: !weekly ? 0 : -screenHeight*0.003)
                                    )
                                    .onTapGesture {
                                        weekly = false
                                    }
                            }
                        }
                    )
                if weekly {
                    Image(.totalPlannedFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.13)
                        .overlay(
                            Text("$\(totalWeek.twoDecimalString)")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.04))
                                .foregroundColor(.red)
                                .shadow(color: .black, radius: 1)
                                .shadow(color: .black, radius: 1)

                                .offset(y: screenHeight*0.03)
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
                                        if item != weeklyStatisticArray.count-1 {
                                            Image(.blackLine)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: screenHeight*0.001)
                                        }
                                    }
                                }
                            }
                        )
                } else {
                    Image(.totalPlannedFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.13)
                        .overlay(
                            Text("$\(totalMonth.twoDecimalString)")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.04))
                                .foregroundColor(.red)
                                .shadow(color: .black, radius: 1)
                                .shadow(color: .black, radius: 1)

                                .offset(y: screenHeight*0.03)
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
                }
                Spacer()
                Image(.makeListButton)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
            }
            BottomBar()
        }
        
        .onAppear {
            getStringDate()
            weeklyDaysArrays = createWeeklyArraysForMonth(dateString: dateString)
            updateAmountArrays()
            everyDaysArrays = createWeekArrayWithDateInCenter(dateString: dateString)
            updateAmountArraysForDays()
        }
        
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
            if weeklyDaysArrays[0].contains(where: { $0 == listArray[i][0] }) && listArray[i][6] == "0" {
                monthlyStatisticArray[0].amount += Double(listArray[i][5]) ?? 0
            }
            if weeklyDaysArrays[1].contains(where: { $0 == listArray[i][0] }) && listArray[i][6] == "0" {
                monthlyStatisticArray[1].amount += Double(listArray[i][5]) ?? 0
            }
            if weeklyDaysArrays[2].contains(where: { $0 == listArray[i][0] }) && listArray[i][6] == "0" {
                monthlyStatisticArray[2].amount += Double(listArray[i][5]) ?? 0
            }
            if weeklyDaysArrays[3].contains(where: { $0 == listArray[i][0] }) && listArray[i][6] == "0" {
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
            if everyDaysArrays[0] == listArray[i][0] && listArray[i][6] == "0" {
                weeklyStatisticArray[0].amount += Double(listArray[i][5]) ?? 0
            }
            if everyDaysArrays[1] == listArray[i][0] && listArray[i][6] == "0" {
                weeklyStatisticArray[1].amount += Double(listArray[i][5]) ?? 0
            }
            if everyDaysArrays[2] == listArray[i][0] && listArray[i][6] == "0" {
                weeklyStatisticArray[2].amount += Double(listArray[i][5]) ?? 0
            }
            if everyDaysArrays[3] == listArray[i][0] && listArray[i][6] == "0" {
                weeklyStatisticArray[3].amount += Double(listArray[i][5]) ?? 0
            }
            if everyDaysArrays[4] == listArray[i][0] && listArray[i][6] == "0" {
                weeklyStatisticArray[4].amount += Double(listArray[i][5]) ?? 0
            }
            if everyDaysArrays[5] == listArray[i][0] && listArray[i][6] == "0" {
                weeklyStatisticArray[5].amount += Double(listArray[i][5]) ?? 0
            }
            if everyDaysArrays[6] == listArray[i][0] && listArray[i][6] == "0" {
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
    
    func getStringDate() {
        dateString = selectedDate.toShortFormat()
    }
    
    func formateWeekDay(date: String) -> String {
        let dateFormatter = Formatter()
        let weekDay = dateFormatter.getWeekdayAbbreviation(date)
        return weekDay
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
    
}

#Preview {
    Home()
}
