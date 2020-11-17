//
//  Card.swift
//  TrucoPaulista
//
//  Created by Felipe Bastos on 10/11/20.
//

import Foundation

struct Card: Codable {
    let code: String?
    let image: String?
    let value: String?
    let suit: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case image = "image"
        case value = "value"
        case suit = "suit"
    }
    
    init(code: String, image: String, value: String, suit: String) {
        self.code = code
        self.image = image
        self.value = value
        self.suit = suit
    }
}

extension Card: Equatable {
    static public func ==(first: Card, second: Card) -> Bool {
        return first.code == second.code
    }
}
