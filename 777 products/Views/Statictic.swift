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
    @State private var sortType = 2
    @State private var сurentDate = Date()
    @State private var dateString: String = ""
    @State private var listArray = UserDefaults.standard.array(forKey: "listArray") as? [[String]] ?? []
    @State private var allTypeProductArray = Arrays.startTemplatesArray
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
                                        }
                                }
//                                .offset(x: screenHeight*0.055)
                            }
                        )
                }
            }
           BottomBar()
        }
        
        .onAppear {
            getStringDate()
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
    
}

#Preview {
    Statictic()
}
