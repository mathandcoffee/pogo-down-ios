//
//  TeamAnalysisVC.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 10/2/22.
//

import UIKit
import Resolver

final class TeamAnalysisVC: UIViewController {
    
    @Injected private var viewModel: TeamBuilderViewModel
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(
            PokemonAnalysisCollectionViewCell.self,
            forCellWithReuseIdentifier: UICollectionViewCell.cellIdentifierForType(
                type: PokemonAnalysisCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        collectionView.backgroundColor = .background
        return collectionView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setupView() {
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TeamAnalysisVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.currentState.availablePokemon.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UICollectionViewCell.cellIdentifierForType(
                type: PokemonAnalysisCollectionViewCell.self),
            for: indexPath) as? PokemonAnalysisCollectionViewCell else {
            fatalError()
        }
        
        return cell
    }
}
