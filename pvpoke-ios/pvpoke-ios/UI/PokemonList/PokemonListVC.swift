//
//  PokemonListVC.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/13/22.
//

import UIKit
import Resolver

final class PokemonListVC: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    @Injected private var viewModel: TeamBuilderViewModel
    
    private var isPresenting = false
    
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
                self?.dismiss()
        })
        let toolbar = Toolbar(configuration: configuration)
        toolbar.backgroundColor = .background
        return toolbar
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
    }
    
    @objc private func swipeGestureDidRecognize(_ gesture: UISwipeGestureRecognizer) {
        self.dismiss()
    }
    
    @objc private func tapGestureDidRecognize(_ gesture: UITapGestureRecognizer) {
        self.dismiss()
    }
    
    private  func dismiss(_ completion: (() -> ())? = nil) {
        presentingViewController?.dismiss(animated: true) {
            completion?()
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
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
    
    func presentView(_ presentedView: UIView, presentingView: UIView, animationDuration: Double, completion: ((_ completed: Bool) -> Void)?) {
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
    
    func dismissView(_ presentedView: UIView, presentingView: UIView, animationDuration: Double, completion: ((_ completed: Bool) -> Void)?) {
        
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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
            strongMoves: chargedMoves
        ) { [unowned self] in
            //TODO: Change pokemon here
        }
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let pokemon = viewModel.currentState.availablePokemon[indexPath.row]

        let height = PokemonCollectionViewCell.height(name: pokemon.speciesName, fastMove: pokemon.fastMoves[0], chargedMoves: pokemon.chargedMoves, collectionView: collectionView)
        
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
}
