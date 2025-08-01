//
//  BottomBar.swift
//  777 products
//
//  Created by Алкександр Степанов on 09.07.2025.
//

import SwiftUI

struct BottomBar: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("selectedMenu") var selectedMenu = 0
    @State private var buttonsArray = Arrays.barButtons
    var body: some View {
        Image(.bottomBar)
            .resizable()
            .scaledToFit()
            .frame(height: screenHeight*0.092)
            .overlay(
                HStack(spacing: screenHeight*0.045) {
                    ForEach(0..<buttonsArray.count, id: \.self) { item in
                        ZStack {
                            VStack {
                                Image(buttonsArray[item].name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.04)
                                Text(buttonsArray[item].text)
                                    .font(Font.custom("Green Mountain 3", size: screenHeight*0.012))
                                    .foregroundColor(item == selectedMenu ? .red : .gray)
                                
                            }
                            if item == selectedMenu {
                                Image(.choseMenuRectangle)
                                    .offset(y: screenHeight*0.032)
                            }
                        }
                        .onTapGesture {
                            selectedMenu = item
                            navigation()
                        }
                        .disabled(selectedMenu == item)
                    }
                }
            )
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            
    }
    
    func navigation() {
        switch selectedMenu {
        case 0:
            NavGuard.shared.currentScreen = .HOME
        case 1:
            NavGuard.shared.currentScreen = .LIST
        case 2:
            NavGuard.shared.currentScreen = .STATISTICS
        case 3:
            NavGuard.shared.currentScreen = .SETTINGS
        default:
            break
        }
    }
    
}

#Preview {
    BottomBar()
}
