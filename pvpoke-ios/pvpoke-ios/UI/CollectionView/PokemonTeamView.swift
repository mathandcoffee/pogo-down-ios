//
//  PokemonTeamView.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/11/22.
//

import UIKit

final class PokemonTeamIndividualView: UIView {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .onBackground
        label.font = .headline4
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    private func setupUI() {
        layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        layer.cornerRadius = 8
        layer.borderWidth = 2
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configure(name: String, tintColor: UIColor) {
        nameLabel.text = name
        layer.borderColor = tintColor.cgColor
        backgroundColor = tintColor.withAlphaComponent(0.7)
    }
}

final class PokemonTeamView: UIView {
    
    private lazy var firstView: PokemonTeamIndividualView = PokemonTeamIndividualView()
    
    private lazy var secondView: PokemonTeamIndividualView = PokemonTeamIndividualView()
    
    private lazy var thirdView: PokemonTeamIndividualView =  PokemonTeamIndividualView()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    private func setupUI() {
        addSubview(firstView)
        firstView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3.0).offset(-8)
        }
        
        addSubview(thirdView)
        thirdView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3.0).offset(-8)
        }
        
        addSubview(secondView)
        secondView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3.0).offset(-8)
        }
    }
    
    func configure(names: [String], tintColors: [UIColor]) {
        firstView.configure(name: names[0], tintColor: tintColors[0])
        secondView.configure(name: names[1], tintColor: tintColors[1])
        thirdView.configure(name: names[2], tintColor: tintColors[2])
    }
}
