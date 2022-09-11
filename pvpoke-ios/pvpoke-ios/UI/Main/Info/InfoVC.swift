//
//  InfoVC.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import Foundation
import Combine

final class InfoVC: BaseViewController {
    typealias STATE = InfoState
    typealias EVENT = InfoEvent
    typealias VIEWMODEL = InfoViewModel
    
    var stateSubscription: AnyCancellable?
    
    var eventSubscription: AnyCancellable?
    
    let viewModel = InfoViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViewModelObservers()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderState(state: InfoState) {
        
    }
    
    func handleEvent(event: InfoEvent) {
        
    }
    
    private func setupView() {
        view.backgroundColor = .background
    }
}
