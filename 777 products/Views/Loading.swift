//
//  Loading.swift
//  777 products
//
//  Created by Алкександр Степанов on 09.07.2025.
//

import SwiftUI

struct Loading: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("bgNimber") var bgNumber = 1
    
    var body: some View {
        ZStack {
            Background(backgroundNumber: bgNumber)
            Text("Loading...")
                .font(Font.custom("Green Mountain 3", size: screenHeight*0.05))
                .foregroundColor(.white)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom)
        }
        
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                coordinator.navigate(to: .home)
            }
        }
        
    }
}

#Preview {
    Loading()
}
