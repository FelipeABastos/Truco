//
//  DrawCard.swift
//  TrucoPaulista
//
//  Created by Felipe Bastos on 10/11/20.
//

import Foundation

struct DrawCard: Codable {
    let success: Bool?
    let id: String?
    let remaining: Int?
    let cards: [Card]
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case id = "deck_id"
        case remaining = "remaining"
        case cards = "cards"
    }
    
    init(success: Bool, deckId: String, remaining: Int, cards: [Card]) {
        self.success = success
        self.id = deckId
        self.remaining = remaining
        self.cards = cards
    }
}
