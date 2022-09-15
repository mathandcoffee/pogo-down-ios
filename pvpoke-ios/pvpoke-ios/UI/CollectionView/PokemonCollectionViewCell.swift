//
//  PokemonCollectionViewCell.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/11/22.
//

import UIKit

final class PokemonCollectionViewCell: UICollectionViewCell {
    
    private var editAction: (() -> Void)?
    
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
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.edit, for: .normal)
        button.backgroundColor = .clear
        button.imageView?.tintColor = .onBackground
        button.addTarget(self, action: #selector(edit), for: .touchUpInside)
        return button
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
            make.trailing.leading.top.equalToSuperview().inset(8.0)
            make.height.equalTo(36)
        }
        
        addSubview(movesLabel)
        movesLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.trailing.leading.bottom.equalToSuperview().inset(8.0)
            make.height.equalTo(48)
        }
        
        addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.top.trailing.equalToSuperview()
        }
    }
    
    func configure(
        tintColor: UIColor,
        name: String,
        fastMove: String,
        strongMoves: [String],
        showEdit: Bool = false,
        editAction: @escaping (() -> Void)
    ) {
        self.editAction = editAction
        backgroundColor = tintColor.withAlphaComponent(0.7)
        layer.borderColor = tintColor.cgColor
        editButton.isHidden = !showEdit
        if !showEdit { editButton.snp.removeConstraints() }
        nameLabel.text = name
        movesLabel.text = Self.movesString(fastMove: fastMove, strongMoves: strongMoves)
    }
    
    private static func movesString(fastMove: String, strongMoves: [String]) -> String {
        if strongMoves.count < 2 {
            return "Fast Move: \(fastMove)"
        }
        return "Fast Move: \(fastMove)\nCharged Moves: \(strongMoves[0]), \(strongMoves[1])"
    }
    
    static func height(name: String, fastMove: String, chargedMoves: [String], collectionView: UICollectionView) -> CGFloat {
        let textWidth = collectionView.frame.width - 16
        let textHeight = name.height(withConstrainedWidth: textWidth, font: .headline2)
        + movesString(fastMove: fastMove, strongMoves: chargedMoves).height(withConstrainedWidth: textWidth, font: .body2) * 2
        return textHeight
    }
    
    @objc private func edit() {
        editAction?()
    }
}
