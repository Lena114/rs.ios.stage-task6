//
//  Player.swift
//  DurakGame
//
//  Created by Дима Носко on 15.06.21.
//

import Foundation

protocol PlayerBaseCompatible {
    var hand: [Card]? { get set }
}

final class Player: PlayerBaseCompatible {
    var hand: [Card]?
    
    func checkIfCanTossWhenAttacking(card: Card) -> Bool {
        if let umwrapped =  hand {
            return umwrapped.first(where: {$0.value == card.value}) != nil
        }
        return false
    }
    
    func checkIfCanTossWhenTossing(table: [Card: Card]) -> Bool {
        for (k, v) in table {
            if (checkIfCanTossWhenAttacking(card: k) || (checkIfCanTossWhenAttacking(card: v))) {
                return true
            }
        }
        return false
    }
}
