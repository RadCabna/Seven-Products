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
                Spacer()
                Image(.makeListButton)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                Image(.addCategoryButton)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .padding(.bottom, screenHeight*0.09)
            }
            BottomBar()
        }
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
