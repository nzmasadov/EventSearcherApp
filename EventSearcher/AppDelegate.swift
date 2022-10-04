//
//  AppDelegate.swift
//  EventSearcher
//
//  Created by Nazim Asadov on 03.10.22.
//

import UIKit
import Swinject
import presentation
import data
import domain
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let assembler = Assembler([DataAssembly(),
                                   DomainAssembly(),
                                   PresentationAssembly()])
          
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        if  FirebaseAuth.Auth.auth().currentUser != nil {
            window?.rootViewController = Router(resolver: assembler.resolver).tabbarViewControllers()
        }
        else {
            window?.rootViewController = Router(resolver: assembler.resolver).loginViewController()
        }
        return true
    }
}
