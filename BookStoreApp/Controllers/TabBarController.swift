//
//  TabBarController.swift
//  BookStoreApp
//
//  Created by Олег Дербин on 23.05.2025.
//

import UIKit

enum TabBarItem {
    case home
    case search
    
    var title: String {
        switch self {
        case .home: "Home"
        case .search: "Search"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .home: UIImage(systemName: "house.fill")
        case .search: UIImage(systemName: "magnifyingglass")
        }
    }
    
    static let allTabBarItems = [home, search]
}

class TabBarController: UITabBarController {
    private let dataSource: [TabBarItem] = [.home, .search]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupNavBar()
    }
}

private extension TabBarController {
    
    func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        self.tabBar.tintColor = .white
        
        let controllers: [UINavigationController] = dataSource.map { item in
            let navVC = UINavigationController()
            
            navVC.tabBarItem.title = item.title
            navVC.tabBarItem.image = item.icon
            
            return navVC
        }
        setViewControllers(controllers, animated: false)
    }
    
    func setupNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .black
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        let navigationBar = UINavigationBar.appearance()
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
