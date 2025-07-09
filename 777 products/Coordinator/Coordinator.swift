//
//  Coordinator.swift
//  777 products
//
//  Created by Алкександр Степанов on 09.07.2025.
//

import Foundation
import SwiftUI

enum CoordinatorView: Equatable {
    case loading
    case home
    case list
    case statistic
    case settings
    
}

final class Coordinator: ObservableObject {
    @Published var path: [CoordinatorView] = []
    
    func resolve(pathItem: CoordinatorView) -> AnyView {
        var view = AnyView(Loading())
        switch pathItem {
        case .loading:
            view = AnyView(Loading())
        case .home:
            view = AnyView(Home())
        case .list:
            view = AnyView(List())
        case .statistic:
            view = AnyView(Statictic())
        case .settings:
            view = AnyView(Settings())
        }
        return view
    }
    
    func navigate(to pathItem: CoordinatorView) {
        path.append(pathItem)
    }
    
    func navigateBack() {
        _ = path.popLast()
    }
}

struct ContentView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        ZStack {
            coordinator.resolve(pathItem: coordinator.path.last ?? .loading)
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    ContentView()
}








