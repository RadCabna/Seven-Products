//
//  AnimateArrow.swift
//  777 products
//
//  Created by Алкександр Степанов on 11.07.2025.
//

import SwiftUI

struct AnimateArrow: View {
    @State private var arrowOffsetY: CGFloat = 0
    @State private var timer: Timer? = nil
    var body: some View {
        Image(.arrowUp)
            .resizable()
            .scaledToFit()
            .frame(height: screenHeight*0.06)
            .offset(y: screenHeight*arrowOffsetY)
            .onAppear {
                animateArrow()
            }
            .onDisappear {
                stopAnimation()
            }
    }
    
    func animateArrow() {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            arrowOffsetY = 0.02
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                arrowOffsetY = 0
            }
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                arrowOffsetY = 0.02
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    arrowOffsetY = 0
                }
            }
        }
    }
    
    func stopAnimation() {
        timer?.invalidate()
        timer = nil
    }
    
}

#Preview {
    AnimateArrow()
}
