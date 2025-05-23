//
//  SceneDelegate.swift
//  BookStoreApp
//
//  Created by Олег Дербин on 12.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let allTabBarItems = TabBarItem.allTabBarItems
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let tabBarController = TabBarController()
        tabBarController.viewControllers?.enumerated().forEach({ index, vc in
            guard let navVC = vc as? UINavigationController else { return }
            pushViewController(index: index, controller: navVC)
        })
        window?.rootViewController = UINavigationController(rootViewController: tabBarController)
        window?.makeKeyAndVisible()
    }
    
}

private extension SceneDelegate {
    func pushViewController(index: Int, controller: UINavigationController) {
        let manager = BookTypeManager()
        
        switch allTabBarItems[index] {
        case .home:
            let homeVC = ViewController(manager: manager)
            controller.pushViewController(homeVC, animated: false)
        case .search:
            let searchVC = MultipleSectionsViewController()
            controller.pushViewController(searchVC, animated: false)
        }
    }
}

