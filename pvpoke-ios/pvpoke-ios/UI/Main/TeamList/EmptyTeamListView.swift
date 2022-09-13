//
//  EmptyTeamListView.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/12/22.
//

import UIKit

final class EmptyTeamListView: UIView {
    
    private lazy var emptyStatePrimaryLabel: UILabel = {
        let label = UILabel()
        label.font = .headline3
        label.textColor = .onBackground
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "You haven't made a team yet!"
        return label
    }()
    
    private lazy var emptyStateSecondaryLabel: UILabel = {
        let label = UILabel()
        label.font = .headline5
        label.textColor = .onBackground
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Try making one!"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(emptyStatePrimaryLabel)
        emptyStatePrimaryLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(24)
        }
        
        addSubview(emptyStateSecondaryLabel)
        emptyStateSecondaryLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyStatePrimaryLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
    }
}
