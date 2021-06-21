import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties
    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
        switch type {
        case .deck36:
            self.cards = createDeck(suits: Suit.allCases, values: Value.allCases)
        default:
            ///TODO: delete if no other cases
            self.cards = createDeck(suits: Suit.allCases, values: Value.allCases)
        }
    }

    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var crds = [Card]()
        for st in suits{
            for vl in values {
                let card = Card(suit: st, value: vl)
                crds.append(card)
            }
        }
        return crds
    }

    public mutating func shuffle() {
        self.cards.shuffle()
    }

    public mutating func defineTrump() {
        if let trmp = self.cards.last{
            self.trump = trmp.suit
            
            setTrumpCards(for: trmp.suit)
        }
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        shuffle()
        defineTrump()
        
        let handsSetSize = 6
        
        for i in 0..<players.count{
            if(self.cards.count >= handsSetSize){
                let handsSet = self.cards[0..<handsSetSize]
                players[i].hand = Array(handsSet)
                self.cards.removeSubrange(0..<handsSetSize)
            }
        }
    }

    public mutating func setTrumpCards(for suit:Suit) {
        for i in 0...self.cards.count-1{
            if(self.cards[i].suit == suit){
                self.cards[i].isTrump = true
            }
        }
    }
}
