//
//  Game.swift
//  DurakGame
//
//  Created by Дима Носко on 16.06.21.
//

import Foundation

protocol GameCompatible {
    var players: [Player] { get set }
}

struct Game: GameCompatible {
    var players: [Player]
}

extension Game {

    func defineFirstAttackingPlayer(players: [Player]) -> Player? {
        
        var trumpCardValues = [Int]()
        
        for player in players {
            for card in player.hand! {
                if card.isTrump {
                    trumpCardValues.append(card.value.rawValue)
                }
            }
        }
        
        let minTrumpCard = trumpCardValues.min()
        
        for player in players {
            for card in player.hand! {
                if card.isTrump && card.value.rawValue == minTrumpCard {
                    return player
                }
            }
        }
        return nil
    }
}
