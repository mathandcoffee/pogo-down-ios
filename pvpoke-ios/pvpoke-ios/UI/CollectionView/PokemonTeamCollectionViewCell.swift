//
//  PokemonTeamCollectionViewCell.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/11/22.
//

import UIKit

final class PokemonTeamCollectionViewCell: UICollectionViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .onBackground
        label.font = .headline2
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var teamView: PokemonTeamView = {
        return PokemonTeamView()
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
            make.trailing.leading.top.equalToSuperview().inset(12.0)
            make.height.equalTo(36)
        }
        
        addSubview(teamView)
        teamView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.trailing.leading.equalToSuperview().inset(16.0)
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(48)
        }
    }
    
    func configure(pokemon: [Pokemon]) {
        nameLabel.text = "Team Allen"
        teamView.configure(
            names: pokemon.map { $0.speciesName },
            tintColors: pokemon.map { UIColor.getColorForPokemonType(pokemonType: $0.types[0]) })
    }
    
    static func height() -> CGFloat {
        return 120
    }
}
