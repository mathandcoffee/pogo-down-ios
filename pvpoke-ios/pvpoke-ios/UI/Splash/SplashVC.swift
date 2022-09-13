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
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = .logo.withTintColor(.onBackground)
        return imageView
    }()
    
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
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
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
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(300)
        }
    }
}
