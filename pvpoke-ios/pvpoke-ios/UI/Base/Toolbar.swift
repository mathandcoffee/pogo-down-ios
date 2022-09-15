//
//  Toolbar.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/14/22.
//

import UIKit

struct ToolbarConfiguration {
    let showBackButton: Bool
    let backTitle: String?
    let title: String?
    let showSearch: Bool
    let dismissAction: (() -> Void)?
}

final class Toolbar: UIView {
    
    weak var delegate: UISearchBarDelegate?
    
    private let configuration: ToolbarConfiguration
    
    init(
        configuration: ToolbarConfiguration
    ) {
        self.configuration = configuration
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        if configuration.showBackButton {
            let button = UIButton()
            addSubview(button)
            button.setImage(.back, for: .normal)
            button.imageView?.tintColor = .onBackground
            button.setTitle(configuration.title, for: .normal)
            button.setTitleColor(.onBackground, for: .normal)
            button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
            button.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(4)
                make.leading.equalToSuperview().inset(8)
            }
        }
        
        if configuration.showSearch {
            let searchBar = UISearchBar()
            addSubview(searchBar)
            searchBar.delegate = delegate
            searchBar.barTintColor = .background
            if let textField = searchBar.value(forKey: "searchField") as? UITextField {
                textField.textColor = .onBackground
                textField.backgroundColor = .surface
                let glassIconView = textField.leftView as? UIImageView
                glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
                glassIconView?.tintColor = .onBackground
            }
            searchBar.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(4)
                make.leading.trailing.equalToSuperview().inset(48)
            }
        }
    }
    
    @objc private func dismiss() {
        configuration.dismissAction?()
    }
}
