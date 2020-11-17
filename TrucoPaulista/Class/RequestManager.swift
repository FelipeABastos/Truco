//
//  RequestManager.swift
//  TrucoPaulista
//
//  Created by Felipe Bastos on 10/11/20.
//

import Foundation

class RequestManager {
    
    public func getCards(cards: [String], _ completion: @escaping (_ success : Bool, _ response: Deck?, _ message: String?) -> Void)  {
        
        let endpoint = "new/shuffle/"
        
        let cardsRepresentation = cards.joined(separator: ",")
        
        let param = ["cards": cardsRepresentation]
        
        Request().request(method: .get, endpoint: endpoint, parameters: param, responseType: Deck.self) { (response, code) in
            
            if let object = response as? Deck, code == 200 {
                
                completion(true, object, "")
            }else{
                completion(false, nil, "")
            }
        }
    }
    
    public func drawCards (deckID: String, cardCount: Int, _ completion: @escaping (_ success : Bool, _ response: DrawCard?, _ message: String?) -> Void)  {
        
        let endpoint = "\(deckID)/draw/"
        
        let param = ["count": cardCount]
        
        Request().request(method: .get, endpoint: endpoint, parameters: param, responseType: DrawCard.self) { (response, code) in
            
            if let object = response as? DrawCard, code == 200 {
                
                completion(true, object, "")
            }else{
                completion(false, nil, "")
            }
        }
    }
}
