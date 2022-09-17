//
//  TeamBuilderVC.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/10/22.
//

import UIKit
import Combine
import Resolver

final class TeamBuilderVC: BaseViewController {
    
    typealias STATE = TeamBuilderState
    typealias EVENT = TeamBuilderEvent
    typealias VIEWMODEL = TeamBuilderViewModel
    
    var stateSubscription: AnyCancellable?
    var eventSubscription: AnyCancellable?
    
    @Injected var viewModel: TeamBuilderViewModel
    
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
    
    private lazy var toolbar: Toolbar = {
        let configuration = ToolbarConfiguration(
            showBackButton: true,
            backTitle: "Teams",
            title: nil,
            showSearch: false,
            dismissAction: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
        })
        return Toolbar(configuration: configuration)
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleButtonPress), for: .touchUpInside)
        button.backgroundColor = .primary
        button.layer.cornerRadius = 24
        button.setTitle("Add Pokemon", for: .normal)
        button.setTitleColor(UIColor.onBackground, for: .normal)
        button.titleLabel?.font = .button
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModelObservers()
        setInitialTeam()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum DataID {
      case row
    }
    
    private func setInitialTeam() {
        if viewModel.currentState.team == nil {
            viewModel.createNewTeam()
        }
    }
    
    func renderState(state: TeamBuilderState) {
        collectionView.reloadData()
        guard let team = state.team else { return }
        if team.pokemon.count < 3 {
            actionButton.setTitle("Add Pokemon", for: .normal)
        } else {
            actionButton.setTitle("Save Team", for: .normal)
        }
    }
    
    func handleEvent(event: TeamBuilderEvent) {
        
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        navigationItem.backButtonTitle = "Teams"
        
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(56)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.width.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(toolbar.snp.bottom)
        }
        
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(150)
            make.height.equalTo(48)
        }
    }
    
    func setTeam(id: UUID) {
        viewModel.retrieveTeamWithId(id)
    }
    
    private func chooseNewPokemon(pokemonIndex: Int) {
        viewModel.selectPokemonToChange(index: pokemonIndex)
        navigateTo(.pokemonList)
    }
    
    @objc private func handleButtonPress() {
        guard let team = viewModel.currentState.team else { return }
        if team.pokemon.count < 3 {
            chooseNewPokemon(pokemonIndex: team.pokemon.count)
        } else {
            viewModel.saveTeam()
        }
    }
}

extension TeamBuilderVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UICollectionViewCell.cellIdentifierForType(
                type: PokemonCollectionViewCell.self
            ),
            for: indexPath
        ) as? PokemonCollectionViewCell else { fatalError() }
        
        guard let pokemon = viewModel.currentState.team?.pokemon[indexPath.row] else { fatalError() }
        let fastMove = viewModel.currentState.moves.first(where: {
            $0.moveId == pokemon.fastMoves[0]
        })?.name ?? ""
        let chargedMoves = viewModel.currentState.moves.filter {
            pokemon.chargedMoves.contains($0.moveId)
        }.map {
            $0.name
        }
        cell.configure(
            tintColor: .getColorForPokemonType(pokemonType: pokemon.types[0]),
            name: pokemon.speciesName,
            fastMove: fastMove,
            strongMoves: chargedMoves,
            showEdit: true
        ) { [unowned self] in
            self.chooseNewPokemon(pokemonIndex: indexPath.row)
        }
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let pokemon = viewModel.currentState.team?.pokemon[indexPath.row] else { fatalError() }

        let height = PokemonCollectionViewCell.height(name: pokemon.speciesName, fastMove: pokemon.fastMoves[0], chargedMoves: pokemon.chargedMoves, collectionView: collectionView)
        
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentState.team?.pokemon.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
           return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
}
