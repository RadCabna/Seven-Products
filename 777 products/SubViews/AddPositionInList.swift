//
//  AddPositionInList.swift
//  777 products
//
//  Created by Алкександр Степанов on 11.07.2025.
//

import SwiftUI

struct AddPositionInList: View {
    @AppStorage("bgNimber") var bgNumber = 1
    @State private var сurentDate = Date()
    @State private var dateString: String = ""
    @State private var image = "productImage1"
    @State private var title = "Apple"
    @State private var amount = "1"
    @State private var units = "p"
    @State private var price = "1.75"
    @State private var newPositionDataArray = ["01.01.25","productImage1","Apple","1", "p","1.75","0"]
    @State private var listArray = UserDefaults.standard.array(forKey: "listArray") as? [[String]] ?? []
    @Binding var addPositionPresented: Bool
    var body: some View {
        ZStack {
            Background(backgroundNumber: bgNumber)
            Text("Add a position")
                .font(Font.custom("Moul-Regular", size: screenHeight*0.025))
                .foregroundColor(.red)
                .shadow(color: .black, radius: 1)
                .shadow(color: .black, radius: 2)
                .frame(maxHeight: screenHeight*0.9, alignment: .top)
            Image(.arrowBack)
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.04)
                .frame(maxWidth: .infinity, maxHeight: screenHeight*0.9, alignment: .topLeading)
                .padding(.horizontal)
                .onTapGesture {
                    addPositionPresented.toggle()
                }
            VStack(spacing: screenHeight*0.03) {
                Spacer()
                Image(.templatesPositionFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.054)
                    .overlay(
                        HStack {
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.04)
                                .frame(maxWidth: screenHeight*0.05)
                            Spacer()
                            Text(title)
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.014))
                                .foregroundColor(.textYellow)
                                .frame(width: screenHeight*0.12)
                                .shadow(color: .black, radius: 1)
                                .shadow(color: .black, radius: 1)
                            Spacer()
                            Text(amount + units)
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.014))
                                .foregroundColor(.textYellow)
                                .frame(width: screenHeight*0.07)
                                .shadow(color: .black, radius: 1)
                                .shadow(color: .black, radius: 1)
                            Spacer()
                            Text(priceFormat(price: price))
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.018))
                                .foregroundColor(.red)
                                .frame(width: screenHeight*0.08)
                                .shadow(color: .black, radius: 1)
                                .shadow(color: .black, radius: 1)
                        }
                            .frame(maxWidth: screenHeight*0.41)
                    )
                Image(.limitFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .overlay(
                        ZStack {
                            Text("Date")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                .foregroundColor(.textYellow)
                                .offset(x: -screenHeight*0.17)
                            HStack {
                                Image(.buttonOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.025)
                                    .onTapGesture {
                                        decreasedDateByDay()
//                                        changeUnits(direction: -1)
//                                        updateUnits()
                                    }
                                RoundedRectangle(cornerRadius: screenHeight*0.01)
                                    .frame(width: screenHeight*0.18, height: screenHeight*0.037)
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
//                                        changeUnits(direction: 1)
//                                        updateUnits()
                                    }
                            }
                            .offset(x: screenHeight*0.055)
                        }
                    )
                Spacer()
                Image(.addPositionButton)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .offset(y: -screenHeight*0.08)
                    .onTapGesture {
                       addNewPositionInList()
//                        UserDefaults.standard.removeObject(forKey: "listArray")
                    }
            }
        }
        
        .onAppear {
            getStringDate()
        }
        
    }
    
    func addNewPositionInList() {
        newPositionDataArray.removeAll()
        newPositionDataArray = [dateString,image,title,amount,units,price,"0"]
        listArray.append(newPositionDataArray)
        UserDefaults.standard.setValue(listArray, forKey: "listArray")
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
    
    func getStringDate() {
        dateString = сurentDate.toShortFormat()
    }
    
    func getDayAndMonth(date: String) -> String {
        let formatter = Formatter()
        return formatter.getMonthAndDay(date)
    }
    
    func priceFormat(price: String) -> String {
        return "$\(price)"
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
    
}

#Preview {
    AddPositionInList(addPositionPresented: .constant(true))
}
