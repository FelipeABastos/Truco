//
//  Deck.swift
//  TrucoPaulista
//
//  Created by Felipe Bastos on 10/11/20.
//

import Foundation

struct Deck: Codable {
    let success: Bool?
    let id: String?
    let remaining: Int?
    let shuffled: Bool?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case id = "deck_id"
        case remaining = "remaining"
        case shuffled = "shuffled"
    }
    
    init(success: Bool, deckId: String, remaining: Int, shuffled: Bool) {
        self.success = success
        self.id = deckId
        self.remaining = remaining
        self.shuffled = shuffled
    }
}


