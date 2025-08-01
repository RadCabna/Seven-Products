import Foundation


enum AvailableScreens {
    case HOME
    case LIST
    case STATISTICS
    case SETTINGS
}

class NavGuard: ObservableObject {
    @Published var currentScreen: AvailableScreens = .HOME
    static var shared: NavGuard = .init()
}

