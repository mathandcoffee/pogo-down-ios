//
//  TeamBuilderVC.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import UIKit
import Combine

final class TeamBuilderVC: BaseViewController {
    
    typealias STATE = TeamBuilderState
    typealias EVENT = TeamBuilderEvent
    typealias VIEWMODEL = TeamBuilderViewModel
    
    var stateSubscription: AnyCancellable?
    var eventSubscription: AnyCancellable?
    
    let viewModel = TeamBuilderViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViewModelObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderState(state: TeamBuilderState) {
        
    }
    
    func handleEvent(event: TeamBuilderEvent) {
        
    }
}
