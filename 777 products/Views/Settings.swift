//
//  Settings.swift
//  777 products
//
//  Created by Алкександр Степанов on 09.07.2025.
//

import SwiftUI

struct Settings: View {
    @AppStorage("bgNimber") var bgNumber = 1
    @AppStorage("sound") var sound = true
    @AppStorage("selectedMenu") var selectedMenu = 0
    @AppStorage("weeklyLimit") var weeklyLimit = "$3000"
    @AppStorage("monthlyLimit") var monthlyLimit = "$12000"
    @State private var bgArray = Arrays.settingsBGArray
    @State private var addPositionsPresented = false
    var body: some View {
        ZStack {
            Background(backgroundNumber: bgNumber)
            VStack(spacing: screenHeight*0.015) {
                Text("Settings")
                    .font(Font.custom("Moul-Regular", size: screenHeight*0.03))
                    .foregroundColor(.red)
                    .shadow(color: .white, radius: 1)
                    .shadow(color: .black, radius: 2)
                Image(.limitFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .overlay(
                        ZStack {
                            Text("Weekly limit")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                .foregroundColor(.textYellow)
                                .offset(x: -screenHeight*0.14)
                            TextField("", text: $weeklyLimit)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.025))
                                .foregroundColor(.red)
                                .onChange(of: weeklyLimit) { newValue in
                                    let cleaned = newValue.filter { $0.isNumber || $0 == "." }
                                    if !cleaned.isEmpty {
                                        weeklyLimit = "$" + cleaned
                                    } else {
                                        weeklyLimit = ""
                                    }
                                }
                                .padding(.horizontal,screenHeight*0.1)
                                .offset(x: screenHeight*0.09)
                        }
                    )
                Image(.limitFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .overlay(
                        ZStack {
                            Text("Monthly limit")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                .foregroundColor(.textYellow)
                                .offset(x: -screenHeight*0.135)
                            TextField("", text: $monthlyLimit)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.025))
                                .foregroundColor(.red)
                                .onChange(of: monthlyLimit) { newValue in
                                    let cleaned = newValue.filter { $0.isNumber }
                                    if !cleaned.isEmpty {
                                        monthlyLimit = "$" + cleaned
                                    } else {
                                        monthlyLimit = ""
                                    }
                                }
                                .padding(.horizontal,screenHeight*0.1)
                                .offset(x: screenHeight*0.09)
                        }
                    )
                Image(.settingsFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.071)
                    .overlay(
                        VStack {
                            Text("Sounds")
                                .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                .foregroundColor(.textYellow)
                            HStack(spacing: screenHeight*0.05) {
                                Image(sound ? .settingOn : .settingOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenHeight*0.1)
                                    .overlay(
                                        Text("On")
                                            .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                            .foregroundColor(.white)
                                            .offset(y: sound ? 0 : -screenHeight*0.003)
                                    )
                                    .onTapGesture {
                                        sound = true
                                    }
                                Image(!sound ? .settingOn : .settingOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenHeight*0.1)
                                    .overlay(
                                        Text("Off")
                                            .font(Font.custom("Green Mountain 3", size: screenHeight*0.02))
                                            .foregroundColor(.white)
                                            .offset(y: !sound ? 0 : -screenHeight*0.003)
                                    )
                                    .onTapGesture {
                                        sound = false
                                    }
                            }
                        }
                    )
                Image(.bgFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.185)
                    .overlay(
                        HStack(spacing: screenHeight*0.03) {
                            ForEach(0..<bgArray.count, id: \.self) { item in
                                ZStack {
                                    Image(bgArray[item])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: screenHeight*0.07)
                                    if item == bgNumber-1 {
                                       AnimateArrow()
                                            .offset(y: screenHeight*0.07)
                                    }
                                }
                                .onTapGesture {
                                    bgNumber = item+1
                                }
                                .offset(y: screenHeight*0.016)
                            }
                        }
                    )
                Spacer()
                Image(.addCategoryButton)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .onTapGesture {
                        addPositionsPresented.toggle()
                    }
                Image(.editPasitionButton)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.05)
                    .padding(.bottom, screenHeight*0.09)
            }
            BottomBar()
        }
        
        .fullScreenCover(isPresented: $addPositionsPresented) {
            AddNewPosition(fromSettings: .constant(true), addPositionPresented: $addPositionsPresented)
        }
        
    }
}

#Preview {
    Settings()
}
