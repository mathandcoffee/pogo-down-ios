//
//  PokemonListVC.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/13/22.
//

import UIKit
import Resolver
import SnapKit

final class PokemonListVC:
    UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    @Injected private var viewModel: TeamBuilderViewModel
    
    private var isPresenting = false
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(
            PokemonCollectionViewCell.self,
            forCellWithReuseIdentifier: UICollectionViewCell.cellIdentifierForType(
                type: PokemonCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        collectionView.backgroundColor = .background
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureDidRecognize(_:)))
        swipeGesture.direction = .down
        collectionView.addGestureRecognizer(swipeGesture)
        return collectionView
    }()
    
    private lazy var toolbar: Toolbar = {
        let configuration = ToolbarConfiguration(
            showBackButton: true,
            backTitle: "Teams",
            title: nil,
            showSearch: true,
            dismissAction: { [weak self] in
                self?.closeActionSheet()
        })
        let toolbar = Toolbar(configuration: configuration)
        toolbar.backgroundColor = .background
        return toolbar
    }()
    
    private lazy var selectedPokemonNameView: UILabel = {
        let label = UILabel()
        label.textColor = .onBackground
        label.font = .headline2
        label.textAlignment = .center
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var movePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .background.withAlphaComponent(0.9)
        picker.delegate = self
        return picker
    }()
    
    private var movePickerDataSource: PokemonMovePickerDataSource? {
        didSet {
            movePicker.dataSource = movePickerDataSource
        }
    }
    
    private lazy var fastMoveSelectionLabel: UITextView = {
        let label = UITextView()
        label.isUserInteractionEnabled = true
        label.isEditable = false
        label.textColor = .onBackground
        label.font = .body2
        label.layer.cornerRadius = 4
        label.textContainerInset = UIEdgeInsets(top: 4, left: 4, bottom: 2, right: 4)
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectFastMove)))
        return label
    }()
    
    private lazy var firstStrongMoveSelectionLabel: UITextView = {
        let label = UITextView()
        label.isUserInteractionEnabled = true
        label.isEditable = false
        label.textColor = .onBackground
        label.font = .body2
        label.layer.cornerRadius = 4
        label.textContainerInset = UIEdgeInsets(top: 4, left: 4, bottom: 2, right: 4)
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectFirstStrongMove)))
        return label
    }()
    
    private lazy var secondStrongMoveSelectionLabel: UITextView = {
        let label = UITextView()
        label.isUserInteractionEnabled = true
        label.isEditable = false
        label.textColor = .onBackground
        label.font = .body2
        label.layer.cornerRadius = 4
        label.textContainerInset = UIEdgeInsets(top: 4, left: 4, bottom: 2, right: 4)
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectSecondStrongMove)))
        return label
    }()
    
    private let containerDismissOverlay = UIView()
    
    private lazy var moveSelectionContainer: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.addSubview(selectedPokemonNameView)
        selectedPokemonNameView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(36)
        }
        
        let fastMoveLabel = UILabel(text: "Fast Move", textColor: .onBackground, font: .headline4)
        let strongMoveLabel = UILabel(text: "Strong Moves", textColor: .onBackground, font: .headline4)
        
        view.addSubview(fastMoveLabel)
        fastMoveLabel.snp.makeConstraints { make in
            make.top.equalTo(selectedPokemonNameView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        view.addSubview(fastMoveSelectionLabel)
        fastMoveSelectionLabel.snp.makeConstraints { make in
            make.top.equalTo(fastMoveLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        view.addSubview(strongMoveLabel)
        strongMoveLabel.snp.makeConstraints { make in
            make.top.equalTo(fastMoveSelectionLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        view.addSubview(firstStrongMoveSelectionLabel)
        firstStrongMoveSelectionLabel.snp.makeConstraints { make in
            make.top.equalTo(strongMoveLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        view.addSubview(secondStrongMoveSelectionLabel)
        secondStrongMoveSelectionLabel.snp.makeConstraints { make in
            make.top.equalTo(firstStrongMoveSelectionLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.width.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        let saveButton = UIButton()
        saveButton.addTarget(self, action: #selector(closeActionSheet), for: .touchUpInside)
        saveButton.backgroundColor = .primary
        saveButton.setTitle("Save Pokemon", for: .normal)
        saveButton.titleLabel?.font = .button
        saveButton.layer.cornerRadius = 8
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(secondStrongMoveSelectionLabel.snp.bottom).offset(36)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(32)
            make.bottom.equalToSuperview().inset(12)
        }
        
        view.isHidden = true
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.background.cgColor
        view.backgroundColor = .background.withAlphaComponent(0.7)
        
        return view
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupUI()
        collectionView.reloadData()
    }
                   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureDidRecognize(_:)))
        let backgroundView = UIView(frame: collectionView.bounds)
        backgroundView.backgroundColor = .background.withAlphaComponent(0.6)
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(tapRecognizer)
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        view.addSubview(toolbar)
        toolbar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(56)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(toolbar.snp.bottom)
        }
        
        view.addSubview(containerDismissOverlay)
        containerDismissOverlay.isHidden = true
        containerDismissOverlay.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(hideContainer)))
        containerDismissOverlay.backgroundColor = .surface.withAlphaComponent(0.5)
        containerDismissOverlay.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.height.width.equalToSuperview()
        }
        
        view.addSubview(moveSelectionContainer)
        moveSelectionContainer.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(48)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().inset(48)
            make.height.equalTo(300)
        }
        
        view.addSubview(movePicker)
        movePicker.isHidden = true
        movePicker.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func hideContainer() {
        moveSelectionContainer.isHidden = true
        containerDismissOverlay.isHidden = true
    }
    
    @objc private func selectFastMove() {
        let moveStrings = viewModel.currentState.currentlySelectedPokemon!.fastMoves.map { moveId in
            viewModel.currentState.moves.first(where: {$0.moveId == moveId})!.name
        }
        movePickerDataSource = PokemonMovePickerDataSource(moves: moveStrings, moveType: .fast)
        movePicker.isHidden = false
    }
    
    @objc private func selectFirstStrongMove() {
        let moveStrings = viewModel.currentState.currentlySelectedPokemon!.chargedMoves.map { moveId in
            viewModel.currentState.moves.first(where: {$0.moveId == moveId})!.name
        }
        movePickerDataSource = PokemonMovePickerDataSource(moves: moveStrings, moveType: .firstCharge)
        movePicker.isHidden = false
    }
    
    @objc private func selectSecondStrongMove() {
        let moveStrings = viewModel.currentState.currentlySelectedPokemon!.chargedMoves.map { moveId in
            viewModel.currentState.moves.first(where: {$0.moveId == moveId})!.name
        }
        movePickerDataSource = PokemonMovePickerDataSource(moves: moveStrings, moveType: .secondCharge)
        movePicker.isHidden = false
    }
    
    @objc private func swipeGestureDidRecognize(_ gesture: UISwipeGestureRecognizer) {
        self.closeActionSheet()
    }
    
    @objc private func tapGestureDidRecognize(_ gesture: UITapGestureRecognizer) {
        self.closeActionSheet()
    }
    
    @objc private func closeActionSheet() {
        if let pokemon = viewModel.currentState.currentlySelectedPokemon {
            viewModel.changePokemonAtChangePosition(pokemon: pokemon)
        }
        presentingViewController?.dismiss(animated: true)
    }
    
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }

    // MARK: - UIViewControllerAnimatedTransitioning
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return isPresenting ? 0 : 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let fromView = fromViewController.view
        
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let toView = toViewController.view
        
        if isPresenting {
            toView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            containerView.addSubview(toView!)
            
            transitionContext.completeTransition(true)
            presentView(toView!, presentingView: fromView!, animationDuration: 0.5, completion: nil)
        } else {
            dismissView(fromView!, presentingView: toView!, animationDuration: 0.5) { completed in
                if completed {
                    fromView?.removeFromSuperview()
                }
                transitionContext.completeTransition(completed)
            }
        }
    }
    
    func presentView(
        _ presentedView: UIView,
        presentingView: UIView,
        animationDuration: Double,
        completion: ((_ completed: Bool) -> Void)?
    ) {
        UIView.animate(withDuration: animationDuration,
                       delay: 0.1,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
                       options: .allowAnimatedContent.union(.allowUserInteraction),
            animations: {
                presentingView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            },
            completion: { finished in
                completion?(finished)
            })
    }
    
    func dismissView(
        _ presentedView: UIView,
        presentingView: UIView,
        animationDuration: Double,
        completion: ((_ completed: Bool) -> Void)?
    ) {
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0.1,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 0.0,
            options: .allowAnimatedContent.union(.allowUserInteraction),
            animations: {
                presentingView.transform = CGAffineTransform.identity
            },
            completion: { _ in
                completion?(true)
            })
    }
}

extension PokemonListVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: UICollectionViewCell.cellIdentifierForType(
                type: PokemonCollectionViewCell.self
            ),
            for: indexPath
        ) as? PokemonCollectionViewCell else { fatalError() }
        
        let pokemon = viewModel.currentState.availablePokemon[indexPath.row]
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
            editAction: nil
        )
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let pokemon = viewModel.currentState.availablePokemon[indexPath.row]
        let height = PokemonCollectionViewCell.height(
            name: pokemon.speciesName,
            fastMove: pokemon.fastMoves[0],
            chargedMoves: pokemon.chargedMoves,
            collectionView: collectionView)
        
        return CGSize(width: collectionView.frame.width - 32, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentState.availablePokemon.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
           return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentSelectedPokemon = viewModel.currentState.availablePokemon[indexPath.row]
        selectedPokemonNameView.text = currentSelectedPokemon.speciesName
        viewModel.selectPokemon(pokemon: currentSelectedPokemon)
        guard let fastMove = viewModel.currentState.moves.first(where: {
            $0.moveId == currentSelectedPokemon.fastMoves[0]
        }) else { return }
        fastMoveSelectionLabel.text = fastMove.name
        fastMoveSelectionLabel.backgroundColor = .getColorForPokemonType(pokemonType: fastMove.type)
        guard let firstStrongMove = viewModel.currentState.moves.first(where: {
            $0.moveId == currentSelectedPokemon.chargedMoves[0]
        }) else { return }
        firstStrongMoveSelectionLabel.text = firstStrongMove.name
        firstStrongMoveSelectionLabel.backgroundColor = .getColorForPokemonType(pokemonType: firstStrongMove.type)
        guard let secondStrongMove = viewModel.currentState.moves.first(where: {
            $0.moveId == currentSelectedPokemon.chargedMoves[1]
        }) else { return }
        secondStrongMoveSelectionLabel.text = secondStrongMove.name
        secondStrongMoveSelectionLabel.backgroundColor = .getColorForPokemonType(pokemonType: secondStrongMove.type)
        moveSelectionContainer.isHidden = false
        containerDismissOverlay.isHidden = false
    }
}

extension PokemonListVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard
            let dataSource = pickerView.dataSource as? PokemonMovePickerDataSource,
            var currentSelectedPokemon = viewModel.currentState.currentlySelectedPokemon else { return }
        
        if currentSelectedPokemon.selectedChargeMove == nil {
            currentSelectedPokemon.selectedChargeMove = [0, 1]
        }
        if currentSelectedPokemon.selectedFastMove == nil {
            currentSelectedPokemon.selectedFastMove = 0
        }
        switch (dataSource.type) {
        case .fast:
            currentSelectedPokemon.selectedFastMove = row
            guard let move = viewModel.currentState.moves.first(where: {
                $0.moveId == currentSelectedPokemon.fastMoves[row]
            }) else { return }
            fastMoveSelectionLabel.text = move.name
            fastMoveSelectionLabel.backgroundColor = .getColorForPokemonType(pokemonType: move.type)
        case .firstCharge:
            currentSelectedPokemon.selectedChargeMove?[0] = row
            guard let move = viewModel.currentState.moves.first(where: {
                $0.moveId == currentSelectedPokemon.chargedMoves[row] }
            ) else { return }
            firstStrongMoveSelectionLabel.text = move.name
            firstStrongMoveSelectionLabel.backgroundColor = .getColorForPokemonType(pokemonType: move.type)
        case.secondCharge:
            currentSelectedPokemon.selectedChargeMove?[1] = row
            guard let move = viewModel.currentState.moves.first(where: {
                $0.moveId == currentSelectedPokemon.chargedMoves[row]
            }) else { return }
            secondStrongMoveSelectionLabel.text = move.name
            secondStrongMoveSelectionLabel.backgroundColor = .getColorForPokemonType(pokemonType: move.type)
        }
        viewModel.changePokemonAtChangePosition(pokemon: currentSelectedPokemon)
        movePicker.isHidden = true
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        attributedTitleForRow row: Int,
        forComponent component: Int
    ) -> NSAttributedString? {
        let dataSource = pickerView.dataSource as? PokemonMovePickerDataSource
        pickerView.subviews[1].backgroundColor = .onBackground.withAlphaComponent(0.3)
        return NSAttributedString(
            string: (dataSource?.moves[row])!,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.onBackground])
    }
}
