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
        label.textColor = .onBackground
        label.font = .headline2
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var movesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .onBackground
        label.font = .body2
        label.textAlignment = .left
        label.numberOfLines = 2
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
        layer.cornerRadius = 8
        layer.borderWidth = 2
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview().inset(16.0)
            make.height.equalTo(36)
        }
        
        addSubview(movesLabel)
        movesLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4.0)
            make.trailing.leading.bottom.equalToSuperview().inset(16.0)
            make.height.equalTo(48)
        }
    }
    
    func configure(
        tintColor: UIColor,
        name: String,
        fastMove: String,
        strongMoves: [String]
    ) {
        backgroundColor = tintColor.withAlphaComponent(0.7)
        layer.borderColor = tintColor.cgColor
        nameLabel.text = name
        movesLabel.text = "Fast Move: \(fastMove)\nCharged Moves: \(strongMoves[0]), \(strongMoves[1])"
    }
    
    private static func movesString(fastMove: String, strongMoves: [String]) -> String {
        return "Fast Move: \(fastMove)\nCharged Moves: \(strongMoves[0]), \(strongMoves[1])"
    }
    
    static func height(name: String, fastMove: String, chargedMoves: [String], collectionView: UICollectionView) -> CGFloat {
        let textWidth = collectionView.frame.width - 32
        let textHeight = name.height(withConstrainedWidth: textWidth, font: .headline2)
        + movesString(fastMove: fastMove, strongMoves: chargedMoves).height(withConstrainedWidth: textWidth, font: .body2) * 2 + 16
        return textHeight
    }
}
