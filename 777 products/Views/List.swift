//
//  List.swift
//  777 products
//
//  Created by Алкександр Степанов on 09.07.2025.
//

import SwiftUI

struct List: View {
    @AppStorage("bgNimber") var bgNumber = 1
    @AppStorage("selectedMenu") var selectedMenu = 0
    @AppStorage("weekly") var weekly = true
    @State private var selectedDate = Date()
    @State private var listArray = UserDefaults.standard.array(forKey: "listArray") as? [[String]] ?? []
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
                Image(.mainListFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.62)
                    .overlay {
                        ZStack {
                            HStack() {
                                Text("Day")
                                    .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                    .foregroundColor(.textYellow)
                                Spacer()
                                Text("Category")
                                    .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                    .frame(width: screenHeight*0.08)
                                    .foregroundColor(.textYellow)
                                Spacer()
                                Text("Title")
                                    .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                    .foregroundColor(.textYellow)
                                    .frame(width: screenHeight*0.08)
                                Spacer()
                                Text("Amount")
                                    .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                    .foregroundColor(.textYellow)
                                    
                                Spacer()
                                Text("Price")
                                    .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                    .foregroundColor(.textYellow)
                                    .frame(width: screenHeight*0.06)
                                Spacer()
                                Text("Bought")
                                    .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                    .foregroundColor(.textYellow)
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                            .frame(maxWidth: screenHeight*0.41)
                            .padding(.top)
                            ScrollView {
                                VStack {
                                    ForEach( 0..<listArray.count, id: \.self) { item in
                                        HStack {
                                            Text(formateWeekDay(date:listArray[item][0]))
                                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.014))
                                                .foregroundColor(.textYellow)
                                                .shadow(color: .black, radius: 1)
                                                .shadow(color: .black, radius: 1)
                                            Spacer()
                                            Image(listArray[item][1])
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: screenHeight*0.035)
                                                .frame(maxWidth: screenHeight*0.05)
                                                .padding(.trailing)
                                            Spacer()
                                            Text(listArray[item][2])
                                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.014))
                                                .foregroundColor(.textYellow)
                                                .frame(width: screenHeight*0.07)
                                                .shadow(color: .black, radius: 1)
                                                .shadow(color: .black, radius: 1)
                                            Spacer()
                                            Text(listArray[item][3] + listArray[item][4])
                                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.015))
                                                .foregroundColor(.textYellow)
                                                .frame(width: screenHeight*0.03)
                                                .shadow(color: .black, radius: 1)
                                                .shadow(color: .black, radius: 1)
                                            Spacer()
                                            Text(priceFormat(price: listArray[item][5]))
                                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.014))
                                                .foregroundColor(.red)
                                                .frame(width: screenHeight*0.06)
                                                .shadow(color: .black, radius: 1)
                                                .shadow(color: .black, radius: 1)
                                            ZStack {
                                                Image(.boughtListRect)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenHeight*0.03)
                                                if listArray[item][6] == "0" {
                                                    Image(.boughtMark)
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: screenHeight*0.024)
                                                }
                                            }
                                            .frame(width: screenHeight*0.05)
                                        }
                                            .frame(maxWidth: screenHeight*0.41)
                                        Image(.blackLine)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: screenHeight*0.001)
                                    }
                                }
                            }
                            .frame(height: screenHeight*0.55)
                            .offset(y: screenHeight*0.02)
                        }
                    }

                Image(.addPositionButton)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                Image(.templatesButton)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                                Spacer()
            }
           BottomBar()
        }
    }
    
    func priceFormat(price: String) -> String {
        return "$\(price)"
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
    
    func formateWeekDay(date: String) -> String {
        let dateFormatter = Formatter()
        let weekDay = dateFormatter.getWeekdayAbbreviation(date)
        return weekDay
    }
    
}

#Preview {
    List()
}
