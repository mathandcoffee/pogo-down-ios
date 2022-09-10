//
//  RootNavigationController.swift
//  mac-dysto-ios
//
//  Created by Bryan Malumphy on 10/22/21.
//

import Foundation
import UIKit

class RootNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationBar.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}
