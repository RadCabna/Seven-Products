//
//  SizeExtention.swift
//  777 products
//
//  Created by Алкександр Степанов on 09.07.2025.
//

import Foundation
import SwiftUI

extension View {
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var deviceHasSafeArea: Bool {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return false
        }
        return window.safeAreaInsets.top > 20
    }
}




