//
//  DashboardVC.swift
//  FuckYouTube
//
//  Created by Bryan Malumphy on 8/8/22.
//

import UIKit
import Combine

final class DashboardVC: BaseViewController {
    typealias STATE = DashboardState
    typealias EVENT = DashboardEvent
    typealias VIEWMODEL = DashboardViewModel
    
    var stateSubscription: AnyCancellable?
    var eventSubscription: AnyCancellable?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViewModelObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel = DashboardViewModel(initialState: DashboardState(createdAt: Date()))
    
    func renderState(state: DashboardState) {
        
    }
    
    func handleEvent(event: DashboardEvent) {
        
    }
}
