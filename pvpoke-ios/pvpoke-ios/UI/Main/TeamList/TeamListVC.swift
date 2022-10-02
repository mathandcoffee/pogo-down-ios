//
//  TeamListVC.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/11/22.
//

import Foundation
import Combine
import UIKit

final class TeamListVC: BaseViewController {
    typealias STATE = TeamListState
    typealias EVENT = TeamListEvent
    typealias VIEWMODEL = TeamListViewModel
    
    var stateSubscription: AnyCancellable?
    
    var eventSubscription: AnyCancellable?
    
    var viewModel = TeamListViewModel()
    
    private lazy var toolbar: Toolbar = {
        return Toolbar(
            configuration: ToolbarConfiguration(
                showBackButton: false, backTitle: nil, title: nil, showSearch: true, dismissAction: nil))
    }()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(
            PokemonTeamCollectionViewCell.self,
            forCellWithReuseIdentifier: UICollectionViewCell.cellIdentifierForType(type: PokemonTeamCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        collectionView.backgroundColor = .background
        return collectionView
    }()
    
    private lazy var emptyStateView: EmptyTeamListView = EmptyTeamListView()
    
    private lazy var addTeamButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(createNewTeam), for: .touchUpInside)
        button.backgroundColor = .primary
        button.layer.cornerRadius = 24
        button.setTitle("Create Team", for: .normal)
        button.setTitleColor(UIColor.onBackground, for: .normal)
        button.titleLabel?.font = .button
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupViewModelObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadTeams()
    }
    
    func renderState(state: TeamListState) {
        collectionView.reloadData()
        collectionView.isHidden = state.teams.isEmpty
        emptyStateView.isHidden = !state.teams.isEmpty
    }
    
    private func setupUI() {
        view.addSubview(emptyStateView)
        emptyStateView.isHidden = true
        emptyStateView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
        }
        
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(56)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(toolbar.snp.bottom)
        }
        
        view.addSubview(addTeamButton)
        addTeamButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(150)
            make.height.equalTo(48)
        }
    }
    
    func handleEvent(event: TeamListEvent) {
        switch event {
        case .showTeam(let teamId):
            navigateToIdentifiable(.teamBuilder, identifier: teamId)
        default:
            return
        }
    }
    
    @objc private func createNewTeam() {
        navigateTo(.teamBuilder)
    }
}

extension TeamListVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UICollectionViewCell.cellIdentifierForType(
                type: PokemonTeamCollectionViewCell.self
            ),
            for: indexPath
        ) as? PokemonTeamCollectionViewCell else { fatalError() }
        let team = viewModel.currentState.teams[indexPath.row]
        cell.configure(pokemon: team.pokemonArray())
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let height = PokemonTeamCollectionViewCell.height()
        
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentState.teams.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
           return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.navigateToTeamAtIndex(indexPath.row)
    }
}
