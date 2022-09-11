//
//  DashboardVC.swift
//  FuckYouTube
//
//  Created by Bryan Malumphy on 8/8/22.
//

import UIKit
import Combine

final class ArticlesVC: BaseViewController {
    typealias STATE = ArticlesState
    typealias EVENT = ArticlesEvent
    typealias VIEWMODEL = ArticlesViewModel
    
    var stateSubscription: AnyCancellable?
    var eventSubscription: AnyCancellable?
    
    var viewModel = ArticlesViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViewModelObservers()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func renderState(state: ArticlesState) {
        
    }
    
    func handleEvent(event: ArticlesEvent) {
        
    }
    
    private func setupView() {
        view.backgroundColor = .background
    }
}
