//
//  _77_productsApp.swift
//  777 products
//
//  Created by Алкександр Степанов on 09.07.2025.
//

import SwiftUI

@main
struct _77_productsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, URLSessionDelegate {
    @AppStorage("levelInfo") var level = false
    @AppStorage("valid") var validationIsOn = false
    static var orientationLock = UIInterfaceOrientationMask.all
    private var validationPerformed = false
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        if OrientationManager.shared.isHorizontalLock {
//            return .landscape
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                AppDelegate().setOrientation(to: .portrait)
            }
        } else {
//            return .allButUpsideDown
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                AppDelegate.orientationLock = .all
            }
        }
        return AppDelegate.orientationLock
    }
}

extension AppDelegate: UIApplicationDelegate {
    
    func setOrientation(to orientation: UIInterfaceOrientation) {
        switch orientation {
        case .portrait:
            AppDelegate.orientationLock = .portrait
        case .landscapeRight:
            AppDelegate.orientationLock = .landscapeRight
        case .landscapeLeft:
            AppDelegate.orientationLock = .landscapeLeft
        case .portraitUpsideDown:
            AppDelegate.orientationLock = .portraitUpsideDown
        default:
            AppDelegate.orientationLock = .all
        }
        
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
}
