//
//  File.swift
//  
//
//  Created by Jullian Mercier on 11/03/2023.
//

import UIKit

enum Tab: Int, CaseIterable {
    case myAccounts
    case myAccountsChart
    
    var image: UIImage? {
        switch self {
        case .myAccounts:
            return UIImage(systemName: "folder")
        case .myAccountsChart:
            return UIImage(systemName: "chart.pie")
        }
    }

    var selectedImage: UIImage? {
        switch self {
        case .myAccounts:
            return UIImage(systemName: "folder.fill")
        case .myAccountsChart:
            return UIImage(systemName: "chart.pie.fill")
        }
    }
    
    var title: String {
        switch self {
        case .myAccounts:
            return "My Accounts"
        case .myAccountsChart:
            return "Chart"
        }
    }
}

public final class AppCoordinator: Coordinator {
    public var parent: Coordinator?
    public var navigationController: UINavigationController?
    public var children: [Coordinator] = []
    
    private let window: UIWindow
    
    private lazy var tabBarController: UITabBarController = {
        let tabBarVc = UITabBarController()
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .white

        tabBarVc.tabBar.standardAppearance = appearance
        tabBarVc.tabBar.scrollEdgeAppearance = appearance
        tabBarVc.tabBar.barTintColor = .black
        tabBarVc.tabBar.tintColor = .black
        
        return tabBarVc
    }()
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    public func start() {
        launchApp()
    }
    
    private func launchApp() {
        let tabBarCoordinators = Tab.allCases.map(makeCoordinator)
        tabBarController.viewControllers = tabBarCoordinators.compactMap(\.navigationController)
        
        tabBarCoordinators.forEach {
            addChild($0)
            $0.start()
        }
        
        window.rootViewController = tabBarController
    }
    
    private func makeCoordinator(for tab: Tab) -> Coordinator {
        let root = UINavigationController()
        root.setNavigationBarHidden(true, animated: false)
        root.tabBarItem.title = tab.title
        root.tabBarItem.image = tab.image
        root.tabBarItem.selectedImage = tab.selectedImage

        let coordinator: Coordinator
        switch tab {
        case .myAccounts:
            coordinator = MyAccountsCoordinator(navigationController: root)
        case .myAccountsChart:
            coordinator = MyAccountsChartCoordinator(navigationController: root)
        }
        return coordinator
    }
    
}
