//
//  PokemonMovePickerDataSource.swift
//  pvpoke-ios
//
//  Created by Bryan Malumphy on 9/17/22.
//

import UIKit
import Resolver

final class PokemonMovePickerDataSource: NSObject, UIPickerViewDataSource {
    
    @Injected private var viewModel: TeamBuilderViewModel
    
    let moves: [String]
    
    let type: MoveType
    
    init(moves: [String], moveType: MoveType) {
        self.moves = moves
        self.type = moveType
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return moves.count
    }
}

enum MoveType {
    case fast
    case firstCharge
    case secondCharge
}
