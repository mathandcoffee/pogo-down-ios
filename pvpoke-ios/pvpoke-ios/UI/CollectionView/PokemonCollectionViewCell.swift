//
//  PokemonCollectionViewCell.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/11/22.
//

import UIKit

final class PokemonCollectionViewCell: UICollectionViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .background
        label.font = .headline2
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var movesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .background
        label.font = .headline4
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.width.leading.equalToSuperview()
            make.height.equalTo(36)
        }
        
        addSubview(movesLabel)
        movesLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.width.leading.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    func configure(
        tintColor: UIColor,
        name: String,
        fastMove: String,
        strongMoves: [String]
    ) {
        backgroundColor = tintColor
        nameLabel.text = name
        movesLabel.text = "\(fastMove)\n\(strongMoves[0]), \(strongMoves[1])"
    }
    
    static func height(for pokemon: Pokemon, collectionView: UICollectionView) -> CGFloat {
        let textWidth = collectionView.frame.width - 32
        let textHeight = pokemon.speciesName.height(withConstrainedWidth: textWidth, font: .headline2)
            + pokemon.fastMoves[0].height(withConstrainedWidth: textWidth, font: .headline4) * 2
        return textHeight
    }
}
