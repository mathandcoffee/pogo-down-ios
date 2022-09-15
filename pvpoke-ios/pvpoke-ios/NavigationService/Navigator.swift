//
//  NavigationService.swift
//  mac-dystoria-ios
//
//  Created by Bryan Malumphy on 11/8/21.
//

import UIKit

enum ViewBuilder {
    case splashScreen
    case main
    case teamBuilder
    case pokemonList
}

extension UIViewController {
    
    //TODO: This will be used to display certain pokemon with IDs
    func navigateToIdentifiable(
        _ viewBuilder: ViewBuilder,
        identifier: Int,
        secondaryIdentifier: Int? = nil,
        containerNavigationController: UINavigationController? = nil
    ) {
        DispatchQueue.main.async {
            let viewController: UIViewController
            switch viewBuilder {
            case .teamBuilder:
                let teamBuilder = TeamBuilderVC()
                teamBuilder.setTeam(id: identifier)
                viewController = teamBuilder
                viewController.modalPresentationStyle = .fullScreen
            default:
                return
            }
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func navigateToWeb(
        header: String,
        url: String,
        containerNavigationController: UINavigationController? = nil
    ) {
        DispatchQueue.main.async {
            let viewController: UIViewController
            viewController = WebViewVC(header: header, url: url)
        
            let navigationController = containerNavigationController ?? self.navigationController
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func navigateTo(
        _ viewBuilder: ViewBuilder,
        injectIntoRootNavigationController: Bool = false,
        containerNavigationController: UINavigationController? = nil
    ) {
        DispatchQueue.main.async {
            let viewController: UIViewController
            switch viewBuilder {
            case .splashScreen:
                viewController = SplashVC()
                viewController.modalTransitionStyle = .crossDissolve
            case .main:
                viewController = MainTabBarController()
                viewController.modalTransitionStyle = .crossDissolve
            case .teamBuilder:
                viewController = TeamBuilderVC()
                viewController.modalPresentationStyle = .fullScreen
            case .pokemonList:
                self.present(PokemonListVC(), animated: true)
                return
            }
            
            if injectIntoRootNavigationController {
                let navController = RootNavigationController(rootViewController: viewController)
                navController.modalTransitionStyle = .crossDissolve
                navController.modalPresentationStyle = .fullScreen
                if viewController is ArticlesVC {
                    navController.interactivePopGestureRecognizer?.isEnabled = false
                } else {
                    navController.interactivePopGestureRecognizer?.isEnabled = true
                }
                self.present(navController, animated: true, completion: nil)
                return
            }
            if viewController is ArticlesVC {
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            } else {
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            }
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
