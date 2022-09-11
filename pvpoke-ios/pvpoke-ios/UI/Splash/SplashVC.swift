//
//  SplashVC.swift
//  FuckYouTube
//
//  Created by Bryan Malumphy on 8/6/22.
//

import UIKit
import Combine

final class SplashVC: BaseViewController {
    typealias STATE = SplashState
    typealias EVENT = SplashEvent
    typealias VIEWMODEL = SplashViewModel
    
    let viewModel = SplashViewModel()
    
    var stateSubscription: AnyCancellable?
    var eventSubscription: AnyCancellable?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViewModelObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            self.viewModel.preloadContent()
        }
    }
    
    func renderState(state: SplashState) {
        //TODO: setup loading indicator state based on state handed
    }
    
    func handleEvent(event: SplashEvent) {
        switch event {
        case .finishedPreloading:
            navigateTo(.main, injectIntoRootNavigationController: true)
        case .preloadingFailed:
            print()
            //TODO: Show alert
        }
    }
    
    func setupView() {
        view.backgroundColor = .background
    }
}
