//
//  MainTabBarController.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let dashboard = DashboardVC()
        dashboard.tabBarItem = UITabBarItem(title: "Dashboard", image: .dashboardIcon, tag: 0)
        
        let teamBuilderVC = TeamBuilderVC()
        teamBuilderVC.tabBarItem = UITabBarItem(title: "Teams", image: .teamBuilderIcon, tag: 1)
        
        viewControllers = [
            dashboard,
            teamBuilderVC
        ]
    }
}
