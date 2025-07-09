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
    var body: some View {
        ZStack {
            Background(backgroundNumber: bgNumber)
            Text("STATISTIC")
                .font(Font.custom("Green Mountain 3", size: screenHeight*0.05))
                .foregroundColor(.white)
           BottomBar()
        }
    }
}

#Preview {
    Statictic()
}
