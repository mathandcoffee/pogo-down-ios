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
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(
            PokemonCollectionViewCell.self,
            forCellWithReuseIdentifier: UICollectionViewCell.cellIdentifierForType(type: PokemonCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        collectionView.backgroundColor = .background
        return collectionView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViewModelObservers()
        setupView()
        viewModel.selectGroup(groupIndex: 13)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum DataID {
      case row
    }
    
    func renderState(state: TeamBuilderState) {
        collectionView.reloadData()
    }
    
    func handleEvent(event: TeamBuilderEvent) {
        
    }
    
    private func setupView() {
        view.backgroundColor = .background
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.height.width.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TeamBuilderVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UICollectionViewCell.cellIdentifierForType(
                type: PokemonCollectionViewCell.self
            ),
            for: indexPath
        ) as? PokemonCollectionViewCell else { fatalError() }
        
        let pokemon = viewModel.currentState.currentPokemonSelection[indexPath.row]
        cell.configure(tintColor: .getColorForPokemonType(pokemonType: pokemon.types[0]), name: pokemon.speciesName, fastMove: pokemon.fastMoves[0], strongMoves: pokemon.chargedMoves)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let pokemon = viewModel.currentState.currentPokemonSelection[indexPath.row]

        let height = PokemonCollectionViewCell.height(for: pokemon, collectionView: collectionView)
        
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentState.currentPokemonSelection.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
           return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
}
