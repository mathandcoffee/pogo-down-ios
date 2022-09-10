//
//  NavigationService.swift
//  mac-dystoria-ios
//
//  Created by Bryan Malumphy on 11/8/21.
//

import UIKit

enum ViewBuilder {
    case splashScreen
    case dashboard
}

extension UIViewController {
    
    func navigateToIdentifiable(
        _ viewBuilder: ViewBuilder,
        identifier: Int,
        secondaryIdentifier: Int? = nil,
        containerNavigationController: UINavigationController? = nil
    ) {
        DispatchQueue.main.async {
            let viewController: UIViewController
            switch viewBuilder {
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
    ){
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
            case .dashboard:
                viewController = DashboardVC()
                viewController.modalTransitionStyle = .crossDissolve
            }
            
            if injectIntoRootNavigationController {
                let navController = RootNavigationController(rootViewController: viewController)
                navController.modalTransitionStyle = .crossDissolve
                navController.modalPresentationStyle = .fullScreen
                if viewController is DashboardVC {
                    navController.interactivePopGestureRecognizer?.isEnabled = false
                } else {
                    navController.interactivePopGestureRecognizer?.isEnabled = true
                }
                self.present(navController, animated: true, completion: nil)
                return
            }
            if viewController is DashboardVC {
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            } else {
                self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            }
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
