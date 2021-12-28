//
//  AppDelegate.swift
//  EstudoTextField
//
//  Created by Marcylene Barreto on 26/12/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let viewController = SignInViewController()
        let navBar = UINavigationController(rootViewController: viewController)
        
        window = UIWindow (frame: UIScreen.main.bounds)
        window?.rootViewController = navBar
        window?.makeKeyAndVisible()
        
        return true
    }

}

