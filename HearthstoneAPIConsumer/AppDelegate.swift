//
//  AppDelegate.swift
//  HearthstoneAPIConsumer
//
//  Created by Johnatas Rodrigues on 27/05/23.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Crie uma instância da CardListViewController
        let cardListViewController = CardListViewController()
        
        // Crie um UINavigationController e defina a CardListViewController como o controlador raiz
        let navigationController = UINavigationController(rootViewController: cardListViewController)
        
        // Defina o UINavigationController como a janela raiz
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

