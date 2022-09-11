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
        // TODO: Determine full functionality of DashboardVC (probably articles from PvPoke)
        let articlesVC = ArticlesVC()
        articlesVC.tabBarItem = UITabBarItem(title: "Articles", image: .articlesIcon, tag: 0)
        
        let teamBuilderVC = TeamBuilderVC()
        teamBuilderVC.tabBarItem = UITabBarItem(title: "Teams", image: .teamBuilderIcon, tag: 1)
        
        let infoVC = InfoVC()
        infoVC.tabBarItem = UITabBarItem(title: "Info", image: .infoIcon, tag: 2)
        
        viewControllers = [
            teamBuilderVC,
            articlesVC,
            infoVC
        ]
        
        view.backgroundColor = .background
    }
}
